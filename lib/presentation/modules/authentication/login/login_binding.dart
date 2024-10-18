import 'package:base/services/auth_service.dart';
import 'package:base/services/user_service.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => LoginController());
  }
}
