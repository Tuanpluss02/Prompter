import 'package:get/get.dart';
import 'change_user_info_controller.dart';

class ChangeUserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeUserInfoController>(() => ChangeUserInfoController());
  }
}
