import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/services/auth_service.dart';
import 'package:base/presentation/shared/global/app_overlay.dart';
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
    final result = await AppOverlay.showLoading(api: _authService.forgotPassword(emailController.text));
    if (result != null) {
      showSnackBar(title: result, type: SnackBarType.error);
    } else {
      showSnackBar(title: 'Email sent successfully', type: SnackBarType.success);
    }
  }
}
