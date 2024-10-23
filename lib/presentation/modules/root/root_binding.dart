import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/services/auth_service.dart';
import 'package:get/get.dart';

import 'root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthService());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => RootController());
  }
}
