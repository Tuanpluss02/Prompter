import 'dart:io';

import 'package:base/common/utils/image_utils.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/shared/utils/call_api_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeUserInfoController extends BaseController {
  final UserService _userService = Get.find<UserService>();
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final FocusNode displayNameFocus = FocusNode();
  final FocusNode usernameFocus = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var avatar = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initUserData();
  }

  onPickImage() async {
    final pickedFile = await ImageUtils.pickImageFromGallery();
    if (pickedFile != null) {
      avatar.value = pickedFile.path;
    }
  }

  void onSubmit() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _updateUserInfo();
  }

  void _initUserData() async {
    avatar.value = appProvider.user.value.profileImage ?? '';
    displayNameController.text = appProvider.user.value.displayName ?? '';
    usernameController.text = appProvider.user.value.username ?? '';
  }

  void _updateUserInfo() async {
    // if nothing changed
    if (displayNameController.text.trim() == appProvider.user.value.displayName &&
        usernameController.text.trim() == appProvider.user.value.username &&
        avatar.value == appProvider.user.value.profileImage) {
      Get.back();
      return;
    }

    final isUsernameExist = await _userService.isUsernameExists(usernameController.text.trim());
    if (usernameController.text.trim() != appProvider.user.value.username && isUsernameExist) {
      showSnackBar(title: 'Username already exists', type: SnackBarType.error);
      return;
    }

    Future<void> process() async {
      if (avatar.value.isNotEmpty && avatar.value != appProvider.user.value.profileImage) {
        final imageUrl = await _cloudinaryService.uploadMultipleImages([File(avatar.value)]);
        avatar.value = imageUrl.first;
      }
      UserEntity updatedUser = appProvider.user.value.copyWith(
        displayName: displayNameController.text.trim(),
        username: usernameController.text.trim(),
        profileImage: avatar.value,
      );
      await _userService.updateUser(updatedUser);
      appProvider.updateUserData(updatedUser);
    }

    await CallApiWidget.showLoading(api: process());
    Get.back();
  }
}
