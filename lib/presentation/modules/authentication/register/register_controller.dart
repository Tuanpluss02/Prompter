import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/services/auth_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/global/app_overlay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

  var obscureText = true.obs;

  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fullNameFocus.requestFocus();
    });
    super.onReady();
  }

  onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    registerWithEmailAndPassword(
        emailController.text.trim(), passwordController.text.trim());
  }

  continueGoogle() async {
    final result = await AppOverlay.showLoading(
      api: _authService.signInWithGoogle(),
    );
    if (result.error == null && result.userCredential == null) {
      return;
    }
    if (result.error != null) {
      showSnackBar(title: result.error!, type: SnackBarType.error);
      return;
    }
    final isExists =
        await _userService.checkUserExists(result.userCredential!.user!.uid);
    if (!isExists) {
      _userService.createUser(result.userCredential!);
    }
    Get.offAllNamed(AppRoutes.root);
  }

  void registerWithEmailAndPassword(String email, String password) async {
    final result = await AppOverlay.showLoading(
      api: _authService.registerWithEmailAndPassword(email, password),
    );
    if (result.error == null && result.userCredential == null) {
      return;
    }
    if (result.error != null) {
      Get.snackbar('Fail', result.error!);
      return;
    }
    await result.userCredential!.user!
        .updateDisplayName(fullNameController.text.trim());
    await _userService.createUser(result.userCredential!,
        displayName: fullNameController.text.trim());
    Get.offAllNamed(AppRoutes.root);
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
