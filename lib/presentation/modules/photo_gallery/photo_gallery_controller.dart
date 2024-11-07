import 'package:base/app/utils/snackbar.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/local/network_exceptions.dart';
import 'package:base/data/repositories/cici_repository.dart';
import 'package:base/data/responses/ai_image_generated.dart';
import 'package:get/get.dart';

class PhotoGalleryController extends BaseController {
  final CiciRepository _ciciRepository = Get.find<CiciRepository>();

  Future<List<ImageList>> initData() async {
    final result = await _ciciRepository.getAiImages();
    List<ImageList> aiImages = <ImageList>[];
    result.when(
      apiSuccess: (res) {
        AiImageGenerated aiImageGenerated = AiImageGenerated.fromJson(res.data);
        aiImages = aiImageGenerated.image?.template!.imageList ?? [];
      },
      apiFailure: (error) {
        final String errorMessage = NetworkExceptions.getErrorMessage(error);
        showSnackBar(title: errorMessage, type: SnackBarType.error);
      },
    );
    return aiImages;
  }
}
