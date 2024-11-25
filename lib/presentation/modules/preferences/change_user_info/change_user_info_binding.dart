import 'package:base/domain/services/cloudinary_service.dart';
import 'package:get/get.dart';

import 'change_user_info_controller.dart';

class ChangeUserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CloudinaryService());
    Get.lazyPut<ChangeUserInfoController>(() => ChangeUserInfoController());
  }
}
