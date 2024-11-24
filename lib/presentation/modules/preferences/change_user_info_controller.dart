import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeUserInfoController extends BaseController {
  final UserService _userService = Get.find<UserService>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var user = UserEntity().obs;

  @override
  void onInit() {
    super.onInit();
    _initUserData();
  }

  void _initUserData() async {
    user.value = await _userService.getUserById(appProvider.currentUserId) ?? UserEntity();
    fullNameController.text = user.value.displayName ?? '';
    emailController.text = user.value.email ?? '';
  }

  void onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _updateUserInfo();
  }

  void _updateUserInfo() async {
    UserEntity updatedUser = user.value.copyWith(
      displayName: fullNameController.text.trim(),
      email: emailController.text.trim(),
    );
    await _userService.updateUser(updatedUser);
    appProvider.updateUserData(updatedUser);
    Get.back();
  }
}
