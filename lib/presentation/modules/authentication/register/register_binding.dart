import 'package:base/services/auth_service.dart';
import 'package:base/services/user_service.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => RegisterController());
  }
}
