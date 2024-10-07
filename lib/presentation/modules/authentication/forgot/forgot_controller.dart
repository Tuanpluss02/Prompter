import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_nums.dart';
import 'package:base/app/constants/tracking_event.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/app/utils/conver_time.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/app/utils/snackbar.dart';
import 'package:base/app/utils/validator_utils.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/local/app_storage.dart';
import 'package:base/data/models/page_data/forgot_page_data.dart';
import 'package:base/data/models/request/reset_password_request.dart';
import 'package:base/data/models/request/send_otp_request.dart';
import 'package:base/data/models/request/verify_otp_request.dart';
import 'package:base/data/models/response/base_response.dart';
import 'package:base/data/models/response/send_otp_response.dart';
import 'package:base/data/models/response/verify_otp_response.dart';
import 'package:base/data/repositories/auth_repository.dart';
import 'package:base/services/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:smart_auth/smart_auth.dart';

enum ForgotStep {
  enterOtp,
  resetPassword;
}

class ForgotController extends BaseController {
  final ForgotPageData pageData;
  ForgotController(this.pageData);

  final AuthRepository _authRepository = AuthRepository();

  // intial page data
  late ForgotPageType type;
  late String avatarLink;
  String? email;
  String? phoneNumber;

  // controller data
  final SmartAuth _smartAuth =
      SmartAuth(); // for android only, for sms listener
  TextEditingController inputController = TextEditingController();
  FocusNode textInputFocusNode = FocusNode();
  Rx<ForgotStep> step = ForgotStep.enterOtp.obs;
  RxBool isShowBtnSubmit = false.obs;

  // reset password data
  String _newPassword = '';
  String _token = '';
  RxBool isShowPassword = false.obs;
  RxBool isHasSpecialCharacter = false.obs;
  RxBool isHasUpperAndLowerCaseAndDigit = false.obs;
  RxBool isLengthValid = false.obs;

  // timer data
  // 2 minutes ~ 120 seconds
  // resendOtpSeconds start from 120 to 0
  Timer? _resendOtpTimer;
  int _resendOtpSeconds = 0;
  RxString resendOtpTime = '0'.obs;
  RxBool isShowTimerButton = true.obs; // show text text button resend otp
  RxBool isEnableResendOtp = true.obs; // enable or disable resend feature
  RxBool isSendingOtp = false.obs; // check if sending otp

  // status otp data
  String _otp = '';
  RxString otpErrorText = ''.obs;

  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  @override
  void onReady() {
    _sendOpt();
    _initListener();
    Future.delayed(const Duration(milliseconds: 500), () {
      textInputFocusNode.requestFocus();
    });
    super.onReady();
  }

  @override
  void onClose() {
    _cancelResendOtpTimer();
    textInputFocusNode.dispose();
    inputController.dispose();
    _smartAuth.removeSmsListener();
    super.onClose();
  }

  _initData() {
    type = pageData.type;
    avatarLink = pageData.avatarLink ?? '';
    if (type == ForgotPageType.email) {
      email = pageData.email;
    } else {
      phoneNumber = pageData.phoneNumber;
    }
  }

  _initListener() {
    inputController.addListener(_validateInputListener);
    inputController.addListener(_removeOtpErrorText);
    if (Platform.isAndroid) {
      _userConsentListener();
    }
  }

  void _removeOtpErrorText() {
    // If the user starts entering input and there is an error message, remove it
    if (otpErrorText.isNotEmpty && inputController.text.trim().isNotEmpty) {
      otpErrorText.value = '';
    }
  }

  void _validateInputListener() {
    if (step.value == ForgotStep.enterOtp) {
      _otp = inputController.text;
      isShowBtnSubmit.value = ValidatorUtils.validateOtp(_otp);
    } else {
      _newPassword = inputController.text;

      isHasSpecialCharacter.value =
          ValidatorUtils.validateHasSpecialCharacter(_newPassword);
      isHasUpperAndLowerCaseAndDigit.value =
          ValidatorUtils.validateHasUpperAndLowerCaseAndDigit(_newPassword);
      isLengthValid.value = ValidatorUtils.validateLengthPassword(_newPassword);

      isShowBtnSubmit.value = isHasSpecialCharacter.value &&
          isHasUpperAndLowerCaseAndDigit.value &&
          isLengthValid.value;

      Log.console('isHasSpecialCharacter: ${isHasSpecialCharacter.value}');
      Log.console(
          'isHasUpperCaseAndDigit: ${isHasUpperAndLowerCaseAndDigit.value}');
      Log.console('isLengthValid: ${isLengthValid.value}');
    }
  }

  void _userConsentListener() async {
    await _smartAuth.getAppSignature();
    final res = await _smartAuth.getSmsCode(useUserConsentApi: true);
    _userConsentListener();
    if (res.codeFound) {
      inputController.text = res.code.toString();
      Log.console(
        'SmsCode: ${res.code}',
        where: 'Function: userConsent - ForgotController',
        level: LogLevel.info,
      );
    } else {
      Log.console(
        'userConsent: $res',
        where: 'Function: userConsent - ForgotController',
        level: LogLevel.error,
      );
    }
    Log.console(
      'userConsent: $res',
      where: 'Function: userConsent - ForgotController',
      level: LogLevel.info,
    );
  }

  _setResendOtpTimer() {
    _cancelResendOtpTimer();

    DateTime sendTime = DateTime.fromMillisecondsSinceEpoch(
        AppStorage.getInt(SharedPreferencesKeys.lastTimeSendForgotOTP) ?? 0);
    DateTime currentTime = DateTime.now();
    final difference = currentTime.difference(sendTime).inSeconds;
    if (sendTime.compareTo(currentTime) <= 0 &&
        difference <= AppNums.resendOtpDelaySeconds) {
      _resendOtpSeconds = AppNums.resendOtpDelaySeconds - difference;
    } else {
      _resendOtpSeconds = AppNums.resendOtpDelaySeconds;
    }

    resendOtpTime.value = convertSecondsToShortFormat(_resendOtpSeconds);
    isShowTimerButton.value = false;

    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      // giây cuối đổ lại mới set resendOtp, không thì huỷ timer
      if (timer.tick <= _resendOtpSeconds) {
        resendOtpTime.value =
            convertSecondsToShortFormat(_resendOtpSeconds - timer.tick);
      }
      // giây sau giây cuối mới bắt đầu được gửi tiếp
      if (timer.tick == _resendOtpSeconds + 1) {
        _cancelResendOtpTimer();
        isShowTimerButton.value = true;
      }
    });
  }

  _cancelResendOtpTimer() {
    Log.console('cancel timer');
    _resendOtpTimer?.cancel();
  }

  resendOtp() async {
    await _sendOpt();
  }

  _sendOpt() async {
    // set is sending otp
    isSendingOtp.value = true;
    // reset error text
    otpErrorText.value = '';
    // Call API to send OTP
    final apiResuilt = await _authRepository.sendOtp(
      SendOtpRequest(
        type: type.value,
        username: type == ForgotPageType.email ? email! : phoneNumber!,
      ),
    );
    apiResuilt.when(
      apiSuccess: (BaseResponse res) {
        switch (res.code) {
          case 0:
            final SendOtpResponse otpRes = SendOtpResponse.fromJson(res.data);
            AppStorage.setInt(SharedPreferencesKeys.lastTimeSendForgotOTP,
                otpRes.timeCurrentSendOtp ?? 0);
            Log.console('Send OTP success: ${res.message}',
                where: 'Function: sendOpt - ForgotController');
            logEventForgotRequestOtpSuccess(
                phoneOrEmail:
                    type == ForgotPageType.email ? email! : phoneNumber!);
            break;
          case 58:
            Log.console('Cant send otp today: ${res.message}',
                where: 'Function: sendOpt - ForgotController');
            otpErrorText.value = res.message ?? '';
            logEventForgotRequestOtpFail(
                phoneOrEmail:
                    type == ForgotPageType.email ? email! : phoneNumber!,
                message: otpErrorText.value);
            isEnableResendOtp.value = false;
            break;
          default:
            Log.console('Send OTP failed: ${res.message}',
                where: 'Function: sendOpt - ForgotController');
            otpErrorText.value = res.message ?? '';
            logEventForgotRequestOtpFail(
                phoneOrEmail:
                    type == ForgotPageType.email ? email! : phoneNumber!,
                message: otpErrorText.value);
            break;
        }
      },
      apiFailure: (NetworkExceptions e) {
        Log.console(
            'Send OTP failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: sendOpt - ForgotController');
        otpErrorText.value = NetworkExceptions.getErrorMessage(e);
      },
    );

    // set timer
    _setResendOtpTimer();
    // set is sending otp end
    isSendingOtp.value = false;
  }

  _submitOpt() async {
    loading.value = true;

    final apiResuilt = await _authRepository.verifyOtp(
      VerifyOtpRequest(
        username: type == ForgotPageType.email ? email! : phoneNumber!,
        otp: _otp,
        usernameType: type.value,
        otpType: OtpTypeEnum.forgotPassword.value,
      ),
    );

    apiResuilt.when(
      apiSuccess: (BaseResponse res) {
        try {
          switch (res.code) {
            case 0:
              Log.console('Verify OTP success: ${res.message}',
                  where: 'Function: submitOtp - ForgotController');
              inputController.clear();
              final VerifyOtpResponse otpRes =
                  VerifyOtpResponse.fromJson(res.data);
              _token = otpRes.token ?? '';
              step.value = ForgotStep.resetPassword;
              Future.delayed(const Duration(milliseconds: 500), () {
                textInputFocusNode.requestFocus();
              });
              break;
            default:
              Log.console('Verify OTP failed: ${res.message}',
                  where: 'Function: submitOtp - ForgotController');
              otpErrorText.value = res.message ?? '';
              break;
          }
        } catch (e) {
          Log.console('Verify OTP failed with exception: ${e.toString()}',
              where: 'Function: submitOtp - ForgotController');
        }
      },
      apiFailure: (NetworkExceptions e) {
        Log.console(
            'Verify OTP failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: submitOtp - ForgotController');
        otpErrorText.value = NetworkExceptions.getErrorMessage(e);
      },
    );

    loading.value = false;
  }

  _resetPassword() async {
    // Call API to reset password
    loading.value = true;

    final apiResuilt = await _authRepository.resetPassword(
      ResetPasswordRequest(
        username: type == ForgotPageType.email ? email! : phoneNumber!,
        password: _newPassword,
        token: _token,
      ),
    );

    apiResuilt.when(
      apiSuccess: (BaseResponse res) {
        try {
          switch (res.code) {
            case 0:
              Log.console('Reset password  success: ${res.message}',
                  where: 'Function: resetPassword - ForgotController');
              logEventForgotUpdatePasswordSuccess(
                  phoneOrEmail:
                      type == ForgotPageType.email ? email! : phoneNumber!);
              onBackpress();
              Future.delayed(const Duration(milliseconds: 500), () {
                showSnackBar(
                  title: tr(LocaleKeys.forgotPassword),
                  message: tr(LocaleKeys.resetPasswordSuccess),
                  type: SnackbarType.success,
                );
              });
              break;
            default:
              Log.console('Reset password failed: ${res.message}',
                  where: 'Function: resetPassword - ForgotController');
              otpErrorText.value = res.message ?? '';
              logEventForgotUpdatePasswordFail(
                  phoneOrEmail:
                      type == ForgotPageType.email ? email! : phoneNumber!,
                  message: otpErrorText.value);
              break;
          }
        } catch (e) {
          Log.console('Reset password failed with exception: ${e.toString()}',
              where: 'Function: resetPassword - ForgotController');
        }
      },
      apiFailure: (NetworkExceptions e) {
        Log.console(
            'Reset password failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: resetPassword - ForgotController');
      },
    );

    loading.value = false;
  }

  onBtnAuthSubmited() {
    textInputFocusNode.unfocus();
    if (step.value == ForgotStep.enterOtp) {
      _submitOpt();
    } else {
      _resetPassword();
    }
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}

extension ForgotTracking on ForgotController {
  /// Log event when send otp success
  /// [phoneOrEmail] is phone number or email
  void logEventForgotRequestOtpSuccess({required String phoneOrEmail}) {
    if (type == ForgotPageType.email) {
      logEvent(
          eventName: TrackingEventConstants.forgotEmail,
          properties: {'email': phoneOrEmail});
    } else {
      logEvent(
          eventName: TrackingEventConstants.forgotPhoneNumber,
          properties: {'phone_number': phoneOrEmail});
    }
  }

  /// Log event when request otp fail
  /// [phoneOrEmail] is phone number or email
  /// [message] is error message
  void logEventForgotRequestOtpFail(
      {required String phoneOrEmail, required String message}) {
    if (type == ForgotPageType.email) {
      logEvent(
          eventName: TrackingEventConstants.forgotRequestOtpFail,
          properties: {'email': phoneOrEmail, 'message': message});
    } else {
      logEvent(
          eventName: TrackingEventConstants.forgotRequestOtpFail,
          properties: {'phone_number': phoneOrEmail, 'message': message});
    }
  }

  /// Log event when update password success
  /// [phoneOrEmail] is phone number or email
  void logEventForgotUpdatePasswordSuccess({required String phoneOrEmail}) {
    if (type == ForgotPageType.email) {
      logEvent(
          eventName: TrackingEventConstants.forgotUpdatePasswordSuccess,
          properties: {'email': phoneOrEmail});
    } else {
      logEvent(
          eventName: TrackingEventConstants.forgotUpdatePasswordSuccess,
          properties: {'phone_number': phoneOrEmail});
    }
  }

  /// Log event when update password fail
  /// [phoneOrEmail] is phone number or email
  /// [message] is error message
  void logEventForgotUpdatePasswordFail(
      {required String phoneOrEmail, required String message}) {
    if (type == ForgotPageType.email) {
      logEvent(
          eventName: TrackingEventConstants.forgotUpdatePasswordFail,
          properties: {'email': phoneOrEmail, 'message': message});
    } else {
      logEvent(
          eventName: TrackingEventConstants.forgotUpdatePasswordFail,
          properties: {'phone_number': phoneOrEmail, 'message': message});
    }
  }
}
