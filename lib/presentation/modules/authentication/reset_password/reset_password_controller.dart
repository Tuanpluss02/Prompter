import 'package:base/domain/services/auth_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      passwordFocus.requestFocus();
    });
    super.onReady();
  }

  String token = Get.parameters['token'] ?? '';

  var obscureText = true.obs;

  onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar('Fail', 'Passwords do not match');
      return;
    }
    resetPassword(passwordController.text.trim());
  }

  resetPassword(String password) async {
    final result = await _authService.resetPassword(password, token);
    if (result == null) {
      Get.snackbar('Successfully', 'Password reset successfully');
    } else {
      Get.snackbar('Fail', result);
    }
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
