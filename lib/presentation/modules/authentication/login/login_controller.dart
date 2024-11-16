import 'package:base/app/utils/snackbar.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/widgets/call_api_widget.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      emailFocus.requestFocus();
    });
    super.onReady();
  }

  var obscureText = true.obs;

  onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    signInWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());
  }

  signInGoogle() async {
    final result = await CallApiWidget.showLoading(
      api: _authService.signInWithGoogle(),
    );
    if (result.error == null && result.userCredential == null) {
      return;
    }
    if (result.error != null) {
      showSnackBar(title: result.error!, type: SnackBarType.error);
      return;
    }
    final isExists = await _userService.checkUserExists(result.userCredential!.user!.uid);
    if (!isExists) {
      _userService.createUser(result.userCredential!);
    }
    Get.offAllNamed(AppRoutes.root);
  }

  signInWithEmailAndPassword(String email, String password) async {
    final result = await CallApiWidget.showLoading(
      api: _authService.signInWithEmailAndPassword(email, password),
    );
    if (result.error == null && result.userCredential == null) {
      return;
    }
    if (result.error != null) {
      showSnackBar(title: result.error!, type: SnackBarType.error);
      return;
    }
    Get.offAllNamed(AppRoutes.root);
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
