import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      if (appProvider.isSignedIn) {
        Get.offAllNamed(AppRoutes.root);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
