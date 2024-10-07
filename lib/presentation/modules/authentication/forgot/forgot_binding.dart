import 'package:base/data/models/page_data/forgot_page_data.dart';
import 'package:base/presentation/modules/authentication/forgot/forgot_controller.dart';
import 'package:get/get.dart';

class ForgotBinding extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    // ForgotPageData is required
    if (args is ForgotPageData) {
      Get.lazyPut(() => ForgotController(args));
    }
  }
}
