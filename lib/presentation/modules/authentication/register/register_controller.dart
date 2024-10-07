import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_nums.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/app/utils/conver_time.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/app/utils/snackbar.dart';
import 'package:base/app/utils/validator_utils.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/local/app_storage.dart';
import 'package:base/data/models/page_data/register_page_data.dart';
import 'package:base/data/models/request/login_request.dart';
import 'package:base/data/models/request/register_request.dart';
import 'package:base/data/models/request/verify_otp_request.dart';
import 'package:base/data/models/response/base_response.dart';
import 'package:base/data/models/response/login_response.dart';
import 'package:base/data/models/response/send_otp_response.dart';
import 'package:base/data/repositories/auth_repository.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/services/api_result.dart';
import 'package:base/services/network_exceptions.dart';
import 'package:get/get.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../../../data/entities/user_entity.dart';

enum RegisterStep {
  enterOtp(1),
  createName(2),
  createPassword(3);

  final int code;

  const RegisterStep(this.code);
}

class RegisterController extends BaseController with RegisterValidator {
  final RegisterPageData pageData;
  RegisterController(this.pageData);

  final AuthRepository _authRepository = AuthRepository();

  // intial page data
  late RegisterPageType type;
  String? email;
  String? phoneNumber;

  // controller data
  final SmartAuth _smartAuth =
      SmartAuth(); // for android only, for sms listener
  TextEditingController inputController = TextEditingController();
  FocusNode textInputFocusNode = FocusNode();
  Rx<RegisterStep> step = RegisterStep.enterOtp.obs;
  RxBool isShowBtnSubmit = false.obs;
  RxBool isShowBtnSubmitName = false.obs;
  RxBool isShowBtnSubmitPassword = false.obs;
  RxBool showTooltip = true.obs;
  User tmpUser = const User(fullName: 'F1 Trading', avatar: '', balance: 0);

  // reset password data
  String _newPassword = '';
  RxBool isShowPassword = false.obs;
  RxBool isHasSpecialCharacter = false.obs;
  RxBool isHasUpperAndLowerCaseAndDigit = false.obs;
  RxBool isLengthValid = false.obs;

  // timer data
  // 2 minutes ~ 120 seconds
  Timer? _resendOtpTimer;
  int _resendOtpSeconds = 0;
  RxString resendOtpTime = '0'.obs;
  RxBool isShowTimerButton = true.obs; // show text text button resend otp
  RxBool isEnableResendOtp = true.obs; // enable or disable resend feature
  RxBool isSendingOtp = false.obs; // check if sending otp

  // status otp data
  String _otp = '';
  String _name = '';
  RxString otpErrorText = ''.obs;
  RxString nameErrorText = ''.obs;

  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  @override
  void onReady() {
    _sendOpt();
    showTooltip.value = true;
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
    if (type == RegisterPageType.email) {
      email = pageData.email;
    } else {
      phoneNumber = pageData.phoneNumber;
    }
  }

  _initListener() {
    inputController.addListener(() {
      if (step.value == RegisterStep.enterOtp) {
        _otp = inputController.text;
        isShowBtnSubmit.value = ValidatorUtils.validateOtp(_otp);
      } else if (step.value == RegisterStep.createName) {
        _name = inputController.text;
        // remember remove this code when be done
        final validName = isValidName(_name);
        if (validName) {
          nameErrorText.value = '';
        } else {
          nameErrorText.value = 'The name cannot contain special characters';
        }

        isShowBtnSubmitName.value = validateName(_name) && validName;
        showTooltip.value = _name.isEmpty && validName;
      } else {
        _newPassword = inputController.text;

        isHasSpecialCharacter.value =
            ValidatorUtils.validateHasSpecialCharacter(_newPassword);
        isHasUpperAndLowerCaseAndDigit.value =
            ValidatorUtils.validateHasUpperAndLowerCaseAndDigit(_newPassword);
        isLengthValid.value =
            ValidatorUtils.validateLengthPassword(_newPassword);

        isShowBtnSubmitPassword.value = isHasSpecialCharacter.value &&
            isHasUpperAndLowerCaseAndDigit.value &&
            isLengthValid.value;

        Log.console('isHasSpecialCharacter: ${isHasSpecialCharacter.value}');
        Log.console(
            'isHasUpperCaseAndDigit: ${isHasUpperAndLowerCaseAndDigit.value}');
        Log.console('isLengthValid: ${isLengthValid.value}');
      }
    });
    if (Platform.isAndroid) {
      _userConsentListener();
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
        where: 'Function: userConsent - RegisterController',
        level: LogLevel.info,
      );
    } else {
      Log.console(
        'userConsent: $res',
        where: 'Function: userConsent - RegisterController',
        level: LogLevel.error,
      );
    }
    Log.console(
      'userConsent: $res',
      where: 'Function: userConsent - RegisterController',
      level: LogLevel.info,
    );
  }

  _setResendOtpTimer() {
    _cancelResendOtpTimer();

    DateTime sendTime = DateTime.fromMillisecondsSinceEpoch(
        AppStorage.getInt(SharedPreferencesKeys.lastTimeSendRegisterOTP) ?? 0);
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
    final apiResuilt = await _authRepository.register(
      RegisterRequest(
        username: type == RegisterPageType.email ? email! : phoneNumber!,
        step: 1,
        type: type.value,
      ),
    );
    apiResuilt.when(
      apiSuccess: (BaseResponse res) {
        switch (res.code) {
          case 0:
            final SendOtpResponse otpRes = SendOtpResponse.fromJson(res.data);
            AppStorage.setInt(SharedPreferencesKeys.lastTimeSendRegisterOTP,
                otpRes.timeCurrentSendOtp ?? 0);
            Log.console('Send OTP success: ${res.message}',
                where: 'Function: sendOpt - RegisterController');
            break;
          case 58:
            Log.console('Cant send otp today: ${res.message}',
                where: 'Function: sendOpt - RegisterController');
            otpErrorText.value = res.message ?? '';
            isEnableResendOtp.value = false;
            break;
          default:
            Log.console('Send OTP failed: ${res.message}',
                where: 'Function: sendOpt - RegisterController');
            otpErrorText.value = res.message ?? '';
            break;
        }
      },
      apiFailure: (NetworkExceptions e) {
        Log.console(
            'Send OTP failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: sendOpt - RegisterController');
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
    textInputFocusNode.unfocus();

    final apiResuilt = await _authRepository.verifyOtp(
      VerifyOtpRequest(
        username: type == RegisterPageType.email ? email! : phoneNumber!,
        otp: _otp,
        usernameType: type.value,
        otpType: OtpTypeEnum.appRegister.value,
      ),
    );

    apiResuilt.when(
      apiSuccess: (BaseResponse res) {
        switch (res.code) {
          case 0:
            Log.console('Verify OTP success: ${res.message}',
                where: 'Function: submitOtp - RegisterController');
            inputController.clear();
            step.value = RegisterStep.createName;
            Future.delayed(const Duration(milliseconds: 500), () {
              textInputFocusNode.requestFocus();
            });
            break;
          default:
            Log.console('Verify OTP failed: ${res.message}',
                where: 'Function: submitOtp - RegisterController');
            otpErrorText.value = res.message ?? '';
            break;
        }
      },
      apiFailure: (NetworkExceptions e) {
        Log.console(
            'Verify OTP failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: submitOtp - RegisterController');
      },
    );

    loading.value = false;
  }

  _submitName() async {
    loading.value = true;
    textInputFocusNode.unfocus();

    final apiResuilt = await _authRepository.register(
      RegisterRequest(
        username: type == RegisterPageType.email ? email! : phoneNumber!,
        step: 2,
        type: type.value,
        fullName: inputController.text,
      ),
    );

    apiResuilt.when(
      apiSuccess: (BaseResponse res) {
        switch (res.code) {
          case 0:
            Log.console('Register fullname success: ${res.message}',
                where: 'Function: registerFullname - RegisterController');
            tmpUser = tmpUser.copyWith(fullName: inputController.text);
            inputController.clear();
            step.value = RegisterStep.createPassword;
            Future.delayed(const Duration(milliseconds: 500), () {
              textInputFocusNode.requestFocus();
            });
            break;
          default:
            Log.console('Register fullname failed: ${res.message}',
                where: 'Function: registerFullname - RegisterController');
            nameErrorText.value = res.message ?? '';
            break;
        }
      },
      apiFailure: (NetworkExceptions e) {
        Log.console(
            'Register fullname failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: registerFullname - RegisterController');
        nameErrorText.value = NetworkExceptions.getErrorMessage(e);
      },
    );
    loading.value = false;
  }

  _createPassword() async {
    // Call API to create password
    loading.value = true;

    final apiResuilt = await _authRepository.register(
      RegisterRequest(
        username: type == RegisterPageType.email ? email! : phoneNumber!,
        step: 3,
        type: type.value,
        password: inputController.text,
      ),
    );

    apiResuilt.when(
      apiSuccess: (BaseResponse res) async {
        switch (res.code) {
          case 0:
            Log.console('Register password success: ${res.message}',
                where: 'Function: registerPassword - RegisterController');
            ApiResult apiLogin =
                await _authRepository.authenticate(LoginRequest(
              username: type == RegisterPageType.email ? email! : phoneNumber!,
              password: inputController.text.trim(),
              type: type.value,
              action: 1,
            ));
            apiLogin.when(
              apiSuccess: (BaseResponse res) async {
                switch (res.code) {
                  case 0:
                    LoginResponseSuccess successResponse =
                        LoginResponseSuccess.fromJson(res.data);
                    appProvider.updateUser(tmpUser);
                    await appProvider.setAuthData(
                        accessToken: successResponse.accessToken!,
                        refreshToken: successResponse.refreshToken!);
                    Log.console(
                        '${AppStorage.getString(SharedPreferencesKeys.accessToken)}');
                    Get.offAllNamed(AppRoutes.root);
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showSnackBar(
                        title: tr(LocaleKeys.register),
                        message: tr(LocaleKeys.registerSuccess),
                        type: SnackbarType.success,
                      );
                    });
                    inputController.clear();
                    break;
                  default:
                    break;
                }
              },
              apiFailure: (NetworkExceptions error) {
                Log.console(NetworkExceptions.getErrorMessage(error));
              },
            );
            break;
          default:
            Log.console('Register password failed: ${res.message}',
                where: 'Function: registerPassword - RegisterController');
            otpErrorText.value = res.message ?? '';
            break;
        }
      },
      apiFailure: (NetworkExceptions e) {
        Log.console(
            'Register password failed connected: ${NetworkExceptions.getErrorMessage(e)}',
            where: 'Function: registerPassword - RegisterController');
      },
    );
    await Future.delayed(const Duration(seconds: 2), () {
      inputController.clear();
      loading.value = false;
    });
  }

  onBtnAuthSubmited() {
    if (step.value == RegisterStep.enterOtp) {
      _submitOpt();
    } else if (step.value == RegisterStep.createName) {
      _submitName();
    } else {
      _createPassword();
    }
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}

mixin RegisterValidator {
  bool validateName(String? value) {
    if (value == null) {
      return false;
    }

    // Kiểm tra nếu độ dài của chuỗi từ 1 trở lên
    return value.isNotEmpty;
  }

  bool isValidName(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    // Regex for Vietnamese and English names
    RegExp validNameRegex = RegExp(
        r'^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềếểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\s]+$');

    // Check if username matches the regex
    return validNameRegex.hasMatch(value);
  }
}
