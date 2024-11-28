import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/ai_image_entity.dart';
import 'package:base/domain/data/local/api_result.dart';
import 'package:base/domain/data/local/network_exceptions.dart';
import 'package:base/domain/data/responses/cici_response.dart';
import 'package:base/domain/data/responses/civit_detail_response.dart';
import 'package:base/domain/data/responses/civit_response.dart';
import 'package:base/domain/data/responses/seaart_response.dart';
import 'package:base/domain/repositories/ai_image_repository.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';

class CivitDetail {
  final String? prompt;
  final String? negativePrompt;
  final String? model;

  CivitDetail({this.prompt, this.negativePrompt, this.model});
}

class PhotoGalleryController extends BaseController {
  final AiImageRepository _aiImageRepository = Get.find<AiImageRepository>();
  final RxList<AiImageEntity> _allAiImages = <AiImageEntity>[].obs;
  final RxList<AiImageEntity> aiImages = <AiImageEntity>[].obs;
  int _currentPage = 0;
  final int _pageSize = 25;

  void _loadPage() {
    final startIndex = _currentPage * _pageSize;
    final endIndex = startIndex + _pageSize;
    aiImages.value = _allAiImages.sublist(startIndex, endIndex.clamp(0, _allAiImages.length));
    aiImages.refresh();
  }

  Future<void> _fetchAllData({bool isFirstTime = false}) async {
    _allAiImages.clear();
    await fetchSeaArtImages();
    if (isFirstTime) await fetchDataCici();
    await fetchDataCivitAI();
    _currentPage = 0;
    _loadPage();
  }

  void refreshData() async {
    isLoading.value = true;
    if (_currentPage * _pageSize + _pageSize < _allAiImages.length) {
      _loadPage();
      _currentPage++;
    } else {
      await _fetchAllData();
    }
    isLoading.value = false;
  }

  @override
  void onReady() {
    super.onReady();
    _fetchAllData(isFirstTime: true);
  }

  Future<void> fetchDataCici() async {
    final result = await _aiImageRepository.getCiCiAiImages();
    result.whenOrNull(
      success: (res) {
        CiciResponse aiImageGenerated = CiciResponse.fromJson(res.data);
        aiImageGenerated.image?.template?.imageList?.forEach((element) {
          _allAiImages.add(
            AiImageEntity(
              id: element.id.toString(),
              imageUrl: element.defaultImage?.url.toString(),
              prompt: element.prompt,
              model: 'CiciAI',
            ),
          );
        });
      },
      failure: (error) {
        final String errorMessage = NetworkExceptions.getErrorMessage(error);
        showSnackBar(title: errorMessage, type: SnackBarType.error);
      },
    );
  }

  Future<void> fetchDataCivitAI() async {
    final ApiResult result = await _aiImageRepository.getCivitAiImages();
    await result.whenOrNull(
      successCustomResponse: (res) async {
        final civitAiResult = CivitAiResponse.fromJson(res);
        civitAiResult.result?.data?.json?.items?.forEach((element) async {
          final detail = await getCivitImageDetails(element.id ?? 41499942);
          if (detail == null) {
            return;
          }
          _allAiImages.add(
            AiImageEntity(
              id: element.id.toString(),
              imageUrl: AiImageAPIPath.civitImageUrl(element.url.toString(), element.id.toString()),
              prompt: detail.prompt,
              negativePrompt: detail.negativePrompt,
              model: detail.model,
            ),
          );
        });
        AiImageRepository.civitCursor = civitAiResult.result?.data?.json?.nextCursor;
      },
      failure: (error) {
        final String errorMessage = NetworkExceptions.getErrorMessage(error);
        showSnackBar(title: errorMessage, type: SnackBarType.error);
      },
    );
  }

  Future<CivitDetail?> getCivitImageDetails(int imageId) async {
    final ApiResult result = await _aiImageRepository.getCivitAiDetail(imageId);
    return result.whenOrNull(
      successCustomResponse: (res) {
        final civitAiDetailResponse = CivitAiDetailResponse.fromJson(res);
        final prompt = civitAiDetailResponse.result?.data?.json?.meta?.prompt;
        final negativePrompt = civitAiDetailResponse.result?.data?.json?.meta?.negativePrompt;
        final model = civitAiDetailResponse.result?.data?.json?.resources;
        var modelString = '';
        if (model != null && model.isNotEmpty) {
          modelString = model.first.baseModel.toString();
        }
        return CivitDetail(prompt: prompt, negativePrompt: negativePrompt, model: modelString);
      },
      failure: (error) {
        final String errorMessage = NetworkExceptions.getErrorMessage(error);
        showSnackBar(title: errorMessage, type: SnackBarType.error);
        return null;
      },
    );
  }

  Future<void> fetchSeaArtImages() async {
    final ApiResult apiResult = await _aiImageRepository.getSeaArtImages();
    apiResult.whenOrNull(
      successCustomResponse: (res) {
        final seaArtResponse = SeaArtResponse.fromJson(res);
        seaArtResponse.data?.items?.forEach((element) {
          _allAiImages.add(
            AiImageEntity(
              id: element.id.toString(),
              imageUrl: element.cover.toString(),
              prompt: element.prompt,
              model: 'SeaArt',
            ),
          );
        });
        AiImageRepository.seaArtPage++;
      },
      failure: (error) {
        final String errorMessage = NetworkExceptions.getErrorMessage(error);
        showSnackBar(title: errorMessage, type: SnackBarType.error);
      },
    );
  }
}
