import 'package:base/base/base_controller.dart';
import 'package:base/services/auth_service.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();

  void signInGoogle() async {
    final result = await _authService.signInWithGoogle();
    print(result);
  }

  void registerWithEmailAndPassword(String email, String password) async {
    final result =
        await _authService.registerWithEmailAndPassword(email, password);
    if (result.error != null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    Get.snackbar('Successfully', 'Register successfully');
  }

  void signInWithEmailAndPassword(String email, String password) async {
    final result =
        await _authService.signInWithEmailAndPassword(email, password);
    if (result.error != null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    Get.snackbar('Successfully', 'Sign in successfully');
  }
}
