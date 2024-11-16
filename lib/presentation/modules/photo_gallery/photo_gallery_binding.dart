import 'package:base/data/repositories/cici_repository.dart';
import 'package:get/get.dart';

import 'photo_gallery_controller.dart';

class PhotoGalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CiciRepository());
    Get.lazyPut(() => PhotoGalleryController());
  }
}
