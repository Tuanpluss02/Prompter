import 'package:base/app/utils/log.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/repositories/cici_repository.dart';
import 'package:base/data/responses/ai_image_generated.dart';
import 'package:get/get.dart';

class PhotoGalleryController extends BaseController {
  final CiciRepository _ciciRepository = Get.find<CiciRepository>();
  var aiImages = <ImageList>[].obs;

  initData() async {
    final result = await _ciciRepository.getAiImages();
    result.when(
      apiSuccess: (res) {
        AiImageGenerated aiImageGenerated = AiImageGenerated.fromJson(res.data);
        aiImages.value = aiImageGenerated.image?.template!.imageList ?? [];
        aiImages.refresh();
      },
      apiFailure: (error) {
        Log.console('Error: $error');
      },
    );
  }

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  void onRefresh() async {
    await initData();
  }
}
