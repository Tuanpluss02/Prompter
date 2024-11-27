import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/local/api_result.dart';
import 'package:base/domain/data/local/network_exceptions.dart';
import 'package:base/domain/data/responses/ai_image_generated.dart';
import 'package:base/domain/repositories/ai_image_repository.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';

class PhotoGalleryController extends BaseController {
  final AiImageRepository _ciciRepository = Get.find<AiImageRepository>();
  var aiImages = <ImageList>[].obs;

  void initData() async {
    final result = await _ciciRepository.getCiCiAiImages();
    result.whenOrNull(
      success: (res) {
        AiImageGenerated aiImageGenerated = AiImageGenerated.fromJson(res.data);
        aiImages.value = aiImageGenerated.image?.template!.imageList ?? [];
        aiImages.refresh();
      },
      failure: (error) {
        final String errorMessage = NetworkExceptions.getErrorMessage(error);
        showSnackBar(title: errorMessage, type: SnackBarType.error);
      },
    );
  }

  void initData2() async {
    final ApiResult result = await _ciciRepository.getCivitAiImages();
    result.whenOrNull(
      successCustomResponse: (res) {
        print(res);
      },
      failure: (error) {
        final String errorMessage = NetworkExceptions.getErrorMessage(error);
        showSnackBar(title: errorMessage, type: SnackBarType.error);
      },
    );
  }

  // @override
  // void onInit() {
  //   initData();
  //   super.onInit();
  // }
}
