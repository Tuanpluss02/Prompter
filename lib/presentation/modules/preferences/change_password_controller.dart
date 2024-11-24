import 'package:base/domain/services/auth_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode currentPasswordFocus = FocusNode();
  final FocusNode newPasswordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      currentPasswordFocus.requestFocus();
    });
    super.onReady();
  }

  var obscureText = true.obs;

  bool isUserLoggedInWithGoogle() {
    return _authService.currentUser?.providerData.any((userInfo) => userInfo.providerId == 'google.com') ?? false;
  }

  onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (newPasswordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar('Fail', 'Passwords do not match');
      return;
    }
    changePassword(currentPasswordController.text.trim(), newPasswordController.text.trim());
  }

  changePassword(String currentPassword, String newPassword) async {
    final result = await _authService.changePassword(currentPassword, newPassword);
    if (result == null) {
      Get.snackbar('Successfully', 'Password changed successfully');
    } else {
      Get.snackbar('Fail', result);
    }
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
