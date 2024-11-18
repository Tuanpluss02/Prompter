import 'package:base/domain/services/cloudinary_service.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:get/get.dart';

import 'new_post_controller.dart';

class NewPostBinding extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    Get.lazyPut(() => CloudinaryService());
    Get.lazyPut(() => PostService());
    if (args != null) {
      Get.lazyPut(() => NewPostController(action: args));
    } else {
      throw Exception('No arguments passed to NewPostBinding');
    }
  }
}
