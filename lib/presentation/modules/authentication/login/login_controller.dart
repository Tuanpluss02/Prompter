import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base/app/constants/tracking_event.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/app/utils/validator_utils.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/models/page_data/forgot_page_data.dart';
import 'package:base/data/models/page_data/register_page_data.dart';
import 'package:base/data/models/request/login_request.dart';
import 'package:base/data/models/response/base_response.dart';
import 'package:base/data/models/response/login_response.dart';
import 'package:base/data/repositories/auth_repository.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/widgets/flipcard/index.dart';
import 'package:base/services/api_result.dart';
import 'package:base/services/network_exceptions.dart';
import 'package:get/get.dart';

/// Define the steps in the login process.
enum LoginStep {
  /// The user enters their phone number or email.
  enterPhoneOrEmail(0),

  /// The user enters their password.
  enterPassword(1);

  /// The code associated with the login step.
  final int code;

  /// Constructor for the LoginStep enum.
  const LoginStep(this.code);
}

/// Define the login methods available.
enum LoginMethod {
  /// Login using a phone number.
  phone(0),

  /// Login using an email address.
  email(1);

  /// The code associated with the login method.
  final int code;

  /// Constructor for the LoginMethod enum.
  const LoginMethod(this.code);
}

/// Controller for the login screen.
class LoginController extends BaseController with LoginValidator {
  /// Controller for the flip card widget.
  final FlipCardController flipCardController = FlipCardController();

  /// Controller for the text input field.
  final TextEditingController textInputController = TextEditingController();

  /// Focus node for the text input field.
  final FocusNode textInputFocusNode = FocusNode();

  /// Repository for authentication-related operations.
  final AuthRepository _authRepository = AuthRepository();

  /// Whether to show the submit button.
  var isShowSubmitButton = false.obs;

  /// Whether to show the password.
  var isShowPassword = false.obs;

  /// Whether the login request is being submitted.
  var isSubmitting = false.obs;

  /// The error message to display.
  var errorText = ''.obs;

  /// The number of times the user has entered an incorrect password.
  var errorCount = 0.obs;

  /// The current step in the login process.
  var loginStep = LoginStep.enterPhoneOrEmail.obs;

  /// The selected login method.
  var loginMethod = LoginMethod.phone.obs;

  /// The entered phone number or email.
  var phoneOrEmailInput = '';

  @override
  void onInit() {
    // Listen for changes in the text input field
    textInputController.addListener(_updateShowSubmitButton);
    textInputController.addListener(_removeErrorText);
    super.onInit();
  }

  ///  Removes the error message when the user starts entering input.
  void _removeErrorText() {
    // If the user starts entering input and there is an error message, remove it
    if (errorText.isNotEmpty && textInputController.text.trim().isNotEmpty) {
      errorText.value = '';
    }
  }

  /// Updates the visibility of the submit button based on the input.
  void _updateShowSubmitButton() {
    final textLength = textInputController.text.trim().length;
    if (loginStep.value == LoginStep.enterPhoneOrEmail) {
      // If the user is entering a phone number,
      // the submit button should be shown when the phone number is 10 digits long
      // If the user is entering an email address,
      // the submit button should be shown when the email address is not empty
      isShowSubmitButton.value = loginMethod.value == LoginMethod.phone
          ? textLength == 10
          : textLength > 0;
    } else {
      // If the user is entering a password,
      // the submit button should be shown when the password is at least 8 characters long
      isShowSubmitButton.value = textLength >= 8;
    }
  }

  @override
  void onReady() {
    super.onReady();
    // Auto open keyboard when screen is ready
    Future.delayed(const Duration(milliseconds: 100), () {
      textInputFocusNode.requestFocus();
    });
  }

  @override
  void onClose() {
    // Dispose of the text input controller and focus node
    textInputController.dispose();
    textInputFocusNode.dispose();
    super.onClose();
  }

  /// Toggles the visibility of the password.
  void toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  /// Handles the pop event.
  void onPopInvoke(bool didPop) {
    if (didPop) {
      return;
    }
    if (loginStep.value == LoginStep.enterPassword) {
      // If the user is on the password step, reset the state to the phone number or email step
      resetStateToLogin();
    } else {
      // If the user is on the phone number or email step, close the screen
      SystemNavigator.pop();
    }
  }

  /// Toggles between phone and email login methods.
  void toggleLoginMethod() {
    loginMethod.value = loginMethod.value == LoginMethod.phone
        ? LoginMethod.email
        : LoginMethod.phone;
    refreshKeyboardType();
  }

  /// Submits the login request.
  void submit() async {
    // Remove any existing error message
    if (errorText.value.isNotEmpty) {
      errorText.value = '';
    }

    /// Validate the input based on the current login step.
    if (!validateInput(
        value: textInputController.text.trim(),
        validator: loginStep.value == LoginStep.enterPassword
            ? passwordValidator
            : (loginMethod.value == LoginMethod.phone
                ? phoneNumberValidator
                : emailValidator))) {
      return;
    }
    // Store the phone number or email address entered by the user before clearing the input field
    if (loginStep.value == LoginStep.enterPhoneOrEmail) {
      phoneOrEmailInput = textInputController.text.trim();
    }

    textInputFocusNode.unfocus();
    isSubmitting.value = true;

    // Minimum delay for the loading indicator to be displayed
    final authenticateResult = await Future.wait([
      _validateAndAuthenticate(),
      Future.delayed(const Duration(milliseconds: 500)),
    ]).then((value) {
      // Return the result of the _validateAndAuthenticate()
      return value.first as bool;
    });

    if (authenticateResult) {
      isSubmitting.value = false;
      // If the user has successfully logged in, navigate to the home screen
      if (loginStep.value == LoginStep.enterPassword) {
        Get.offAllNamed(AppRoutes.root);
        return;
      }
      textInputController.clear();
      if (appProvider.user.value.avatar!.isNotEmpty) {
        flipCardController.flipcard();
      }
      loginStep.value = LoginStep.enterPassword;
      Future.delayed(const Duration(milliseconds: 100), () {
        textInputFocusNode.requestFocus();
      });
    }
    isSubmitting.value = false;
  }

  /// Validates the user input and authenticates the user.
  ///
  /// Returns true if the authentication is successful, false otherwise.
  Future<bool> _validateAndAuthenticate() async {
    bool result = false;

    ApiResult apiResult = await _authRepository.authenticate(LoginRequest(
      username: phoneOrEmailInput.trim(),
      password: textInputController.text.trim(),
      type: loginMethod.value.code,
      action: loginStep.value.code,
    ));

    await apiResult.when(apiSuccess: (BaseResponse res) async {
      result = switch (res.code) {
        // When the user has entered the correct phone number or email
        0 => await _onLoginSuccess(res),
        // When the user does not have an account
        2 => _onDontHaveAccount(res),
        // When the user has entered the wrong password
        3 => _onLoginFail(res),
        // When the user has entered the invalid phone number or email
        _ => await _onUnknownError(res),
      };
    }, apiFailure: (NetworkExceptions e) {
      errorText.value = NetworkExceptions.getErrorMessage(e);
    });
    return result;
  }

  /// Validates the given input value using the provided validator function.
  ///
  /// Returns true if the input is valid, false otherwise.
  bool validateInput(
      {required String? Function(String?)? validator, required String? value}) {
    errorText.value = validator!(value) ?? '';
    return errorText.value.isEmpty;
  }

  /// Resets the login state to the initial step.
  void resetStateToLogin() {
    isShowPassword = false.obs;
    isSubmitting.value = false;
    loginStep.value = LoginStep.enterPhoneOrEmail;
    errorCount.value = 0;
    errorText.value = '';
    // If the card is flipped, flip it back
    if (flipCardController.state!.isFront == false) {
      flipCardController.flipcard();
    }
    refreshKeyboardType();
  }

  /// Refreshes the keyboard type and clears the input field.
  void refreshKeyboardType() {
    errorText.value = '';
    isSubmitting.value = false;
    textInputController.clear();
    textInputFocusNode.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () {
      textInputFocusNode.requestFocus();
    });
  }

  /// Navigates to the forgot password screen.
  goToForgotPassword() async {
    await Get.toNamed(
      AppRoutes.forgot,
      arguments: ForgotPageData(
        type: loginMethod.value == LoginMethod.phone
            ? ForgotPageType.phone
            : ForgotPageType.email,
        phoneNumber:
            loginMethod.value == LoginMethod.phone ? phoneOrEmailInput : null,
        email:
            loginMethod.value == LoginMethod.email ? phoneOrEmailInput : null,
        avatarLink: appProvider.user.value.avatar,
      ),
    );
    resetStateToLogin();
  }

  _goToRegisterPage() async {
    Log.console('phone in login: ${textInputController.text}');
    Log.console('email $phoneOrEmailInput');
    await Get.toNamed(
      AppRoutes.register,
      arguments: RegisterPageData(
        type: loginMethod.value == LoginMethod.phone
            ? RegisterPageType.phone
            : RegisterPageType.email,
        phoneNumber:
            loginMethod.value == LoginMethod.phone ? phoneOrEmailInput : null,
        email:
            loginMethod.value == LoginMethod.email ? phoneOrEmailInput : null,
      ),
    );
    resetStateToLogin();
  }
}

extension LoginProcess on LoginController {
  Future<bool> _onLoginSuccess(BaseResponse res) async {
    if (loginStep.value == LoginStep.enterPhoneOrEmail) {
      LoginVerifyUsernameResponse verifySuccessResponse =
          LoginVerifyUsernameResponse.fromJson(res.data);
      appProvider.updateUser(appProvider.user.value.copyWith(
        avatar: verifySuccessResponse.avatarUrl,
        fullName: verifySuccessResponse.fullName,
      ));
      await posthogManager.identify(userId: phoneOrEmailInput);
      return true;
    }
    LoginResponseSuccess successResponse =
        LoginResponseSuccess.fromJson(res.data);
    appProvider.setAuthData(
        accessToken: successResponse.accessToken!,
        refreshToken: successResponse.refreshToken!);
    logLoginSuccessEvent(phoneOrEmailInput: phoneOrEmailInput);
    return true;
  }

  bool _onLoginFail(BaseResponse res) {
    LoginResponseError failedResponse = LoginResponseError.fromJson(res.data);
    errorCount.value = failedResponse.countError ?? 0;
    errorText.value = errorCount.value == 1
        ? tr(LocaleKeys.wrongPasswordFirstTime)
        : (errorCount.value >= 2 && errorCount.value <= 4
            ? tr(LocaleKeys.wrongPasswordMultipleTimes,
                namedArgs: {'time': errorCount.value.toString()})
            : res.message ?? '');
    logLoginFailEvent(
        phoneOrEmailInput: phoneOrEmailInput, message: errorText.value);
    return false;
  }

  Future<bool> _onUnknownError(BaseResponse res) async {
    errorText.value = res.message ?? '';
    await posthogManager.identify(userId: phoneOrEmailInput);
    logNotExistEvent(
        phoneOrEmailInput: phoneOrEmailInput, message: errorText.value);
    return false;
  }

  bool _onDontHaveAccount(BaseResponse res) {
    _goToRegisterPage();
    return false;
  }
}

extension LoginTracking on LoginController {
  /// Logs the event check phone number or email is not exist.
  /// [phoneOrEmailInput] is the phone number or email entered by the user.
  /// [message] is the error message to display.
  void logNotExistEvent(
      {required String phoneOrEmailInput, required String message}) {
    if (loginMethod.value == LoginMethod.phone) {
      logEvent(
        eventName: TrackingEventConstants.checkPhoneNumberNotExist,
        properties: {'phone_number': phoneOrEmailInput, 'message': message},
      );
    } else {
      logEvent(
        eventName: TrackingEventConstants.checkEmailNotExist,
        properties: {'email': phoneOrEmailInput, 'message': message},
      );
    }
  }

  /// Logs the event login phone number or email success.
  /// [phoneOrEmailInput] is the phone number or email entered by the user.
  void logLoginSuccessEvent({required String phoneOrEmailInput}) async {
    if (loginMethod.value == LoginMethod.phone) {
      logEvent(
        eventName: TrackingEventConstants.loginPhoneNumberSuccess,
        properties: {'phone_number': phoneOrEmailInput},
      );
    } else {
      logEvent(
        eventName: TrackingEventConstants.loginEmailSuccess,
        properties: {'email': phoneOrEmailInput},
      );
    }
  }

  /// Logs the event login phone number or email fail.
  /// [phoneOrEmailInput] is the phone number or email entered by the user.
  /// [message] is the error message to display.
  void logLoginFailEvent(
      {required String phoneOrEmailInput, required String message}) {
    if (loginMethod.value == LoginMethod.phone) {
      logEvent(
        eventName: TrackingEventConstants.loginPhoneNumberFail,
        properties: {'phone_number': phoneOrEmailInput, 'message': message},
      );
    } else {
      logEvent(
        eventName: TrackingEventConstants.loginEmailFail,
        properties: {'phone_number': phoneOrEmailInput, 'message': message},
      );
    }
  }
}

/// Mixin providing validation functions for login fields.
mixin LoginValidator {
  /// Validates the phone number.
  String? phoneNumberValidator(String? value) {
    if (value!.isEmpty) {
      return tr(LocaleKeys.plsEnterField,
          namedArgs: {'field': tr(LocaleKeys.phoneNumber)});
    }
    if (!ValidatorUtils.isPhoneNumber(
        ValidatorUtils.normalizePhoneNumber(value))) {
      return tr(LocaleKeys.invalidField,
          namedArgs: {'field': tr(LocaleKeys.phoneNumber)});
    }
    return null;
  }

  /// Validates the email address.
  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return tr(LocaleKeys.plsEnterField,
          namedArgs: {'field': tr(LocaleKeys.email)});
    }
    if (!ValidatorUtils.isValidEmai(value)) {
      return tr(LocaleKeys.invalidField,
          namedArgs: {'field': tr(LocaleKeys.email)});
    }
    return null;
  }

  /// Validates the password.
  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return tr(LocaleKeys.plsEnterField,
          namedArgs: {'field': tr(LocaleKeys.password)});
    }
    return null;
  }
}
