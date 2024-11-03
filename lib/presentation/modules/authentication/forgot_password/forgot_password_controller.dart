import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      emailFocus.requestFocus();
    });
    super.onReady();
  }

  void onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    // Handle forgot password logic here
  }
}
