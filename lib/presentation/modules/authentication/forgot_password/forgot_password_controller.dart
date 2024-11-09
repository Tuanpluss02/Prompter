import 'package:base/presentation/widgets/call_api_widget.dart';
import 'package:base/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthService _authService = Get.find<AuthService>();

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      emailFocus.requestFocus();
    });
    super.onReady();
  }

  void onSubmit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    final result = await CallApiWidget.showLoading(api: _authService.forgotPassword(emailController.text));
    if (result != null) {
      Get.snackbar('Error', result ?? 'An error occurred. Please try again later');
    } else {
      Get.snackbar('Success', 'Please check your email to reset password');
    }
  }
}