import 'package:get/get.dart';

import 'new_post_controller.dart';

class NewPostBinding extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    if (args != null) {
      Get.lazyPut(() => NewPostController(action: args));
    } else {
      throw Exception('No arguments passed to NewPostBinding');
    }
  }
}
