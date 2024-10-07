import 'package:base/data/models/page_data/register_page_data.dart';
import 'package:base/presentation/modules/authentication/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    // Register is required
    if (args is RegisterPageData) {
      Get.lazyPut(() => RegisterController(args));
    }
  }
}
