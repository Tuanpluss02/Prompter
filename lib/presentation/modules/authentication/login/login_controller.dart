import 'package:base/base/base_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/services/auth_service.dart';
import 'package:base/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    signInWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());
  }

  void signInGoogle() async {
    final result = await _authService.signInWithGoogle();
    if (result.error == null || result.userCredential == null) {
      return;
    }
    if (result.error != null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    final user = result.userCredential?.user;
    await _userService.createUser(user!.uid, user.email!.split('@')[0], user.email!);
    Get.toNamed(AppRoutes.root);
    Get.snackbar('Successfully', 'Sign in with Google successfully');
  }

  void logout() async {
    await _authService.signOut();
    Get.snackbar('Successfully', 'Logout successfully');
  }

  void signInWithEmailAndPassword(String email, String password) async {
    final result = await _authService.signInWithEmailAndPassword(email, password);
    if (result.error == null || result.userCredential == null) {
      return;
    }
    if (result.error != null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    Get.toNamed(AppRoutes.root);
    Get.snackbar('Successfully', 'Sign in successfully');
  }
}
