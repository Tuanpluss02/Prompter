import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/app/utils/snackbar.dart';
import 'package:base/app/utils/validator_utils.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/models/request/change_password_request.dart';
import 'package:base/data/models/response/base_response.dart';
import 'package:base/data/repositories/auth_repository.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/widgets/overlay_success_mission.dart';
import 'package:base/services/api_result.dart';
import 'package:base/services/network_exceptions.dart';
import 'package:get/get.dart';

enum ChangePasswordStep {
  confirmOldPassword(1),
  changePassword(2);

  final int value;
  const ChangePasswordStep(this.value);
}

enum TypeInput {
  oldPassword,
  newPassword,
  confirmPassword,
}

class ChangePasswordController extends BaseController {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);

  final AuthRepository _authRepository = AuthRepository();

  final TextEditingController oldPasswordInputController =
      TextEditingController();
  final TextEditingController newPasswordInputController =
      TextEditingController();
  final TextEditingController confirmPasswordInputController =
      TextEditingController();

  final FocusNode oldPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final RxBool isShowOldPassword = false.obs;
  final RxBool isShowNewPassword = false.obs;
  final RxBool isShowConfirmPassword = false.obs;

  final RxBool isHasSpecialCharacter = false.obs;
  final RxBool isHasUpperAndLowerCaseAndDigit = false.obs;
  final RxBool isLengthValid = false.obs;
  final RxBool isMatchPassword = false.obs;

  final RxBool isNewPassswordFocus = false.obs;
  final RxBool isConfirmPasswordFocus = false.obs;

  final RxString errorOldPasswordText = ''.obs;

  Rx<ChangePasswordStep> step = Rx(ChangePasswordStep.confirmOldPassword);

  @override
  void onInit() {
    super.onInit();
    addFocusListener();
    addTextEditingControllerListener();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 500), () {
      oldPasswordFocusNode.requestFocus();
    });
  }

  @override
  onClose() {
    oldPasswordInputController.dispose();
    newPasswordInputController.dispose();
    confirmPasswordInputController.dispose();

    oldPasswordFocusNode.dispose();
    newPasswordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    pageController.dispose();
    super.dispose();
  }

  addFocusListener() {
    oldPasswordFocusNode.addListener(() {
      if (oldPasswordFocusNode.hasFocus) {
        isNewPassswordFocus.value = false;
        isConfirmPasswordFocus.value = false;
      }
    });

    newPasswordFocusNode.addListener(() {
      if (newPasswordFocusNode.hasFocus) {
        isNewPassswordFocus.value = true;
        isConfirmPasswordFocus.value = false;
      }
    });

    confirmPasswordFocusNode.addListener(() {
      if (confirmPasswordFocusNode.hasFocus) {
        isNewPassswordFocus.value = false;
        isConfirmPasswordFocus.value = true;
      }
    });
  }

  void addTextEditingControllerListener() {
    newPasswordInputController.addListener(() {
      final password = newPasswordInputController.text;
      isHasSpecialCharacter.value =
          ValidatorUtils.validateHasSpecialCharacter(password);
      isHasUpperAndLowerCaseAndDigit.value =
          ValidatorUtils.validateHasUpperAndLowerCaseAndDigit(password);
      isLengthValid.value = ValidatorUtils.validateLengthPassword(password);
    });

    confirmPasswordInputController.addListener(() {
      isMatchPassword.value = newPasswordInputController.text ==
              confirmPasswordInputController.text &&
          newPasswordInputController.text.isNotEmpty;
    });
  }

  void toggleShowOldPassword(TypeInput type) {
    switch (type) {
      case TypeInput.oldPassword:
        isShowOldPassword.value = !isShowOldPassword.value;
        break;
      case TypeInput.newPassword:
        isShowNewPassword.value = !isShowNewPassword.value;
        break;
      case TypeInput.confirmPassword:
        isShowConfirmPassword.value = !isShowConfirmPassword.value;
        break;
    }
  }

  void reFocusRequest() {
    if (oldPasswordFocusNode.hasFocus) {
      oldPasswordFocusNode.requestFocus();
    }
    if (newPasswordFocusNode.hasFocus) {
      newPasswordFocusNode.requestFocus();
    }
    if (confirmPasswordFocusNode.hasFocus) {
      confirmPasswordFocusNode.requestFocus();
    }
  }

  void changeToStep(ChangePasswordStep toStep) {
    if (toStep == ChangePasswordStep.confirmOldPassword) {
      step.value = ChangePasswordStep.confirmOldPassword;
      oldPasswordFocusNode.requestFocus();
      pageController.animateToPage(0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      step.value = ChangePasswordStep.changePassword;
      newPasswordFocusNode.requestFocus();
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void onBackClick() {
    Log.console('onBackClick');
    if (step.value == ChangePasswordStep.changePassword) {
      changeToStep(ChangePasswordStep.confirmOldPassword);
    } else {
      Get.back();
    }
  }

  void onButtonClick() async {
    Log.console('onButtonClick');
    loading.value = true;
    if (step.value == ChangePasswordStep.confirmOldPassword) {
      await confirmOldPassword();
    } else {
      await changePassword();
    }
    loading.value = false;
  }

  Future<void> confirmOldPassword() async {
    if (oldPasswordInputController.text.isEmpty) {
      errorOldPasswordText.value = tr(
        LocaleKeys.pleaseEnterYourField,
        namedArgs: {
          'field': tr(LocaleKeys.currentPassword).toLowerCase(),
        },
      );
      return;
    }

    final ApiResult result = await _authRepository.confirmAndChangePassword(
      ChangePasswordRequest(
        step: step.value.value,
        oldPassword: oldPasswordInputController.text,
      ),
    );

    result.when(
      apiSuccess: (BaseResponse response) {
        try {
          switch (response.code) {
            case 0:
              Log.console('confirm pass success',
                  where:
                      'Function: conficonfirmOldPasswordrm - ChangedPasswordController');
              errorOldPasswordText.value = '';
              changeToStep(ChangePasswordStep.changePassword);
              break;
            default:
              Log.console('confirm pass failed with code: ${response.code}',
                  where:
                      'Function: confirmOldPassword - ChangedPasswordController');
              errorOldPasswordText.value =
                  response.message ?? 'Something went wrong!';
              break;
          }
        } catch (e) {
          Log.console('confirm pass failed with exception: $e',
              where:
                  'Function: changeconfirmOldPassword - ChangedPasswordController');
          errorOldPasswordText.value = e.toString();
        }
      },
      apiFailure: (e) {
        Log.console(
            'confirm pass failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: confirmOldPassword - ChangedPasswordController');
        errorOldPasswordText.value = NetworkExceptions.getErrorMessage(e);
      },
    );
  }

  Future<void> changePassword() async {
    if (isValidateChangePassword() == false) {
      return;
    }

    final ApiResult result = await _authRepository.confirmAndChangePassword(
      ChangePasswordRequest(
        step: step.value.value,
        oldPassword: oldPasswordInputController.text,
        password: newPasswordInputController.text,
      ),
    );

    result.when(
      apiSuccess: (BaseResponse response) {
        try {
          switch (response.code) {
            case 0:
              Log.console('Changed pass success',
                  where:
                      'Function: changePassword - ChangedPasswordController');
              Get.offAllNamed(AppRoutes.login);
              Future.delayed(const Duration(milliseconds: 500), () {
                showBadgeNotification(
                  context: Get.context!,
                  title: tr(LocaleKeys.password),
                  content: tr(LocaleKeys.updateSuccess),
                  prefixWidget: Image.asset(
                    ImagePath.imgSuccess,
                    fit: BoxFit.contain,
                    width: 38,
                    height: 38,
                  ),
                );
              });
              break;
            default:
              Log.console('Changed pass failed with code: ${response.code}',
                  where:
                      'Function: changePassword - ChangedPasswordController');
              break;
          }
        } catch (e) {
          Log.console('Changed pass failed with exception: $e',
              where: 'Function: changePassword - ChangedPasswordController');
        }
      },
      apiFailure: (e) {
        Log.console(
            'Changed pass failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: changePassword - ChangedPasswordController');
      },
    );
  }

  isValidateChangePassword() {
    if (newPasswordInputController.text.isEmpty) {
      newPasswordFocusNode.requestFocus();
      showSnackBar(
          title: tr(LocaleKeys.changePassword),
          message: tr(LocaleKeys.newPasswordMustNotBeEmpty),
          type: SnackbarType.error);
      return false;
    }

    if (newPasswordInputController.text.contains(' ')) {
      newPasswordFocusNode.requestFocus();
      showSnackBar(
          title: tr(LocaleKeys.changePassword),
          message: tr(LocaleKeys.passwordMustNotContainSpace),
          type: SnackbarType.error);
      return false;
    }

    if (newPasswordInputController.text
            .compareTo(oldPasswordInputController.text) ==
        0) {
      newPasswordFocusNode.requestFocus();
      showSnackBar(
          title: tr(LocaleKeys.changePassword),
          message: tr(LocaleKeys.newPasswordMustBeDifferentFromOldPassword),
          type: SnackbarType.error);
      return false;
    }

    if (!isHasSpecialCharacter.value ||
        !isHasUpperAndLowerCaseAndDigit.value ||
        !isLengthValid.value) {
      newPasswordFocusNode.requestFocus();
      showSnackBar(
          title: tr(LocaleKeys.changePassword),
          message: tr(LocaleKeys.newPasswordNotValid),
          type: SnackbarType.error);
      return false;
    }

    if (confirmPasswordInputController.text.isEmpty) {
      confirmPasswordFocusNode.requestFocus();
      showSnackBar(
          title: tr(LocaleKeys.changePassword),
          message: tr(LocaleKeys.pleaseReEnterPassword),
          type: SnackbarType.error);
      return false;
    }

    if (newPasswordInputController.text !=
        confirmPasswordInputController.text) {
      confirmPasswordFocusNode.requestFocus();
      showSnackBar(
          title: tr(LocaleKeys.changePassword),
          message: tr(LocaleKeys.reEnteredPasswordDoesNotMatch),
          type: SnackbarType.error);
      return false;
    }

    if (!isMatchPassword.value) {
      confirmPasswordFocusNode.requestFocus();
      showSnackBar(
          title: tr(LocaleKeys.changePassword),
          message: tr(LocaleKeys.reEnteredPasswordDoesNotMatch),
          type: SnackbarType.error);
      return false;
    }

    return true;
  }
}
