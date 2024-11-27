import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/ai_image_entity.dart';
import 'package:base/domain/data/local/api_result.dart';
import 'package:base/domain/data/local/network_exceptions.dart';
import 'package:base/domain/data/responses/cici_response.dart';
import 'package:base/domain/data/responses/civit_detail_response.dart';
import 'package:base/domain/data/responses/civit_response.dart';
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
  var aiImages = <AiImageEntity>[].obs;

  void initData() async {
    final result = await _aiImageRepository.getCiCiAiImages();
    result.whenOrNull(
      success: (res) {
        CiciResponse aiImageGenerated = CiciResponse.fromJson(res.data);
        aiImageGenerated.image?.template?.imageList?.forEach((element) {
          aiImages.add(
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

  void initData2() async {
    final ApiResult result = await _aiImageRepository.getCivitAiImages();
    result.whenOrNull(
      successCustomResponse: (res) async {
        final civitAiResult = CivitAiResponse.fromJson(res);
        civitAiResult.result?.data?.json?.items?.forEach((element) async {
          final detail = await getCivitImageDetails(element.id ?? 41499942);
          if (detail == null) {
            return;
          }
          aiImages.add(
            AiImageEntity(
              id: element.id.toString(),
              imageUrl: AiImageAPIPath.civitImageUrl(element.url.toString(), element.id.toString()),
              prompt: detail.prompt,
              negativePrompt: detail.negativePrompt,
              model: detail.model,
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

  @override
  void onInit() {
    // initData();
    initData2();
    super.onInit();
  }
}
