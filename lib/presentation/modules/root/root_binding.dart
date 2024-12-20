import 'package:base/domain/repositories/ai_image_repository.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/presentation/modules/account/account_controller.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/modules/photo_gallery/photo_gallery_controller.dart';
import 'package:base/presentation/modules/search/search_controller.dart';
import 'package:get/get.dart';

import 'root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostService());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchController());
    Get.lazyPut(() => AiImageRepository());
    Get.lazyPut(() => PhotoGalleryController());
    Get.lazyPut(() => AccountController());
    Get.lazyPut(() => RootController());
  }
}
