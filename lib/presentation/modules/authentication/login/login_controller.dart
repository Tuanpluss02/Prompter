import 'package:base/base/base_controller.dart';
import 'package:base/services/auth_service.dart';
import 'package:base/services/user_service.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

  void signInGoogle() async {
    final result = await _authService.signInWithGoogle();
    if (result.error != null || result.userCredential == null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    final user = result.userCredential?.user;
    _userService.createUser(user!.uid, user.email!.split('@')[0], user.email!);
    Get.snackbar('Successfully', 'Sign in with Google successfully');
  }

  void registerWithEmailAndPassword(String email, String password) async {
    final result = await _authService.registerWithEmailAndPassword(email, password);
    if (result.error != null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    Get.snackbar('Successfully', 'Register successfully');
  }

  void logout() async {
    await _authService.signOut();
    Get.snackbar('Successfully', 'Logout successfully');
  }

  void signInWithEmailAndPassword(String email, String password) async {
    final result = await _authService.signInWithEmailAndPassword(email, password);
    if (result.error != null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    Get.snackbar('Successfully', 'Sign in successfully');
  }
}
