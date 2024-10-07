import 'package:base/data/models/page_data/verify_account_page_data.dart';
import 'package:base/data/repositories/ekyc_repository.dart';
import 'package:base/presentation/modules/authentication/verify_account/verify_account_controller.dart';
import 'package:get/get.dart';

class VerifyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EkycRepository());

    var args = Get.arguments;

    if (args != null && args is VerifyAccountPageData) {
      Get.lazyPut(() => VerifyAccountController(pageData: args));
    } else {
      Get.lazyPut(
          () => VerifyAccountController(pageData: VerifyAccountPageData()));
    }
  }
}
