import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/models/request/register_email_otp_request.dart';
import 'package:base/data/models/request/register_pin_request.dart';
import 'package:base/data/models/request/update_pin_request.dart';
import 'package:base/data/models/request/verify_confirm_request.dart';
import 'package:base/data/models/request/verify_pin_request.dart';
import 'package:base/data/models/request/verify_smart_otp_request.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';

class SettingApiPath {
  static const String configInfo = '/info/${AppStrings.apiVersion}';
  static const String registerPin = '/register/pin/${AppStrings.apiVersion}';
  static const String verifyConfirm =
      '/verify/confirm/${AppStrings.apiVersion}';
  static const String updatePin = '/update/pin/${AppStrings.apiVersion}';
  static const String getConfigSmartOTP =
      '/register/smart_otp/${AppStrings.apiVersion}';
  static const String getConfigEmailOTP =
      '/register/email_otp/${AppStrings.apiVersion}';
  static const String verifyPin = '/verify/pin/${AppStrings.apiVersion}';
  static const String sendOtpActionSmart =
      '/send_otp/smart_otp/${AppStrings.apiVersion}';
  static const String registerEmailOTP =
      '/register/email_otp/${AppStrings.apiVersion}';
  static const String sendOtpActionEmail =
      '/send_otp/email_otp/${AppStrings.apiVersion}';
  static const String cancelSmartOTP =
      '/cancel/smart_otp/${AppStrings.apiVersion}';
  static const String cancelEmailOTP =
      '/cancel/email_otp/${AppStrings.apiVersion}';
  static const String cancelFaceIdOTP =
      '/cancel/face_id/${AppStrings.apiVersion}';
  static const String verifySmartOTP =
      '/verify/smart_otp/${AppStrings.apiVersion}';
  static const String configForgotPin = '/forgot_pin/${AppStrings.apiVersion}';
  static const String registerFaceId =
      '/register/face_id/${AppStrings.apiVersion}';
  static const String sendOTPFaceId =
      '/send_otp/face_id/${AppStrings.apiVersion}';

  static String sendOTPTrade(String action) =>
      '/send_otp_trade/$action/${AppStrings.apiVersion}';
}

class SettingRepository extends BaseRepository {
  SettingRepository() : super(baseUrl: AppStrings.baseUrlConfig);

  Future<ApiResult> fetchUserConfig() async {
    return handleApiRequest(() => dioClient.get(SettingApiPath.configInfo));
  }

  Future<ApiResult> registerPin(RegisterPinRequest request) async {
    return handleApiRequest(() =>
        dioClient.post(SettingApiPath.registerPin, data: request.toJson()));
  }

  Future<ApiResult> verifyConfirm(VerifyConfirmRequest request) async {
    return handleApiRequest(() =>
        dioClient.post(SettingApiPath.verifyConfirm, data: request.toJson()));
  }

  Future<ApiResult> updatePin(UpdatePinRequest request) async {
    return handleApiRequest(
        () => dioClient.put(SettingApiPath.updatePin, data: request.toJson()));
  }

  Future<ApiResult> getConfigSmartOTP() async {
    return handleApiRequest(
        () => dioClient.post(SettingApiPath.getConfigSmartOTP));
  }

  Future<ApiResult> getConfigEmailOTP(RegisterEmailOTPRequest request) async {
    return handleApiRequest(() => dioClient
        .post(SettingApiPath.getConfigEmailOTP, data: request.toJson()));
  }

  Future<ApiResult> verifyPin(VerifyPinRequest request) async {
    return handleApiRequest(
        () => dioClient.post(SettingApiPath.verifyPin, data: request.toJson()));
  }

  Future<ApiResult> sendOtpActionSmart() async {
    return handleApiRequest(
        () => dioClient.get(SettingApiPath.sendOtpActionSmart));
  }

  Future<ApiResult> registerEmailOTP(RegisterEmailOTPRequest request) async {
    return handleApiRequest(() => dioClient
        .post(SettingApiPath.registerEmailOTP, data: request.toJson()));
  }

  Future<ApiResult> sendOtpActionEmail() async {
    return handleApiRequest(
        () => dioClient.get(SettingApiPath.sendOtpActionEmail));
  }

  Future<ApiResult> cancelSmartOTP() async {
    return handleApiRequest(
        () => dioClient.post(SettingApiPath.cancelSmartOTP));
  }

  Future<ApiResult> cancelEmailOTP() async {
    return handleApiRequest(
        () => dioClient.post(SettingApiPath.cancelEmailOTP));
  }

  Future<ApiResult> verifySmartOTP(VerifySmartOtpRequest request) async {
    return handleApiRequest(() =>
        dioClient.post(SettingApiPath.verifySmartOTP, data: request.toJson()));
  }

  Future<ApiResult> configForgotPin() async {
    return handleApiRequest(
        () => dioClient.get(SettingApiPath.configForgotPin));
  }

  Future<ApiResult> senOTPTrade(action) async {
    return handleApiRequest(
        () => dioClient.get(SettingApiPath.sendOTPTrade(action)));
  }

  Future<ApiResult> registerFaceId() async {
    return handleApiRequest(
        () => dioClient.post(SettingApiPath.registerFaceId));
  }

  Future<ApiResult> senOTPFaceId() async {
    return handleApiRequest(() => dioClient.get(SettingApiPath.sendOTPFaceId));
  }

  Future<ApiResult> cancelFaceId() async {
    return handleApiRequest(
        () => dioClient.post(SettingApiPath.cancelFaceIdOTP));
  }
}
