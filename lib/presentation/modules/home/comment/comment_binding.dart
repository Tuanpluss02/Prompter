import 'package:base/common/constants/app_type.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:get/get.dart';

import 'comment_controller.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    Get.lazyPut(() => CloudinaryService());
    if (args is NewsFeedPost) {
      Get.lazyPut(() => CommentController(newsFeedPost: args));
    } else {
      throw Exception('Invalid arguments');
    }
  }
}
