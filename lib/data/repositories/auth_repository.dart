import 'dart:convert';

import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/models/request/change_password_request.dart';
import 'package:base/data/models/request/login_request.dart';
import 'package:base/data/models/request/register_request.dart';
import 'package:base/data/models/request/reset_password_request.dart';
import 'package:base/data/models/request/send_otp_request.dart';
import 'package:base/data/models/request/verify_otp_request.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';

import '../../services/network_exceptions.dart';
import '../models/response/base_response.dart';

class AuthApiPath {
  static const String login = '/api/app/auth/login/${AppStrings.apiVersion}';
  // forgot password
  static const String sendOtp =
      '/api/app/auth/forgot_pass/send_otp/${AppStrings.apiVersion}';
  static const String verifyOtp =
      '/api/app/auth/verify_otp/${AppStrings.apiVersion}';
  static const String resetPassword =
      '/api/app/auth/forgot_pass/${AppStrings.apiVersion}';
  // register
  static const String register =
      '/api/app/auth/register/${AppStrings.apiVersion}';

  // changed password
  static const String confirmAndChangePassword =
      '/api/app/profile/update/password';
}

class AuthRepository extends BaseRepository {
  AuthRepository() : super(baseUrl: AppStrings.baseUrlAuth);

  Future<ApiResult> authenticate(LoginRequest request) async {
    return handleApiRequest(
        () => dioClient.post(AuthApiPath.login, data: request.toJson()));
  }

  Future<ApiResult> sendOtp(SendOtpRequest request) async {
    return handleApiRequest(
        () => dioClient.post(AuthApiPath.sendOtp, data: request.toJson()));
  }

  Future<ApiResult> verifyOtp(VerifyOtpRequest request) async {
    return handleApiRequest(
        () => dioClient.post(AuthApiPath.verifyOtp, data: request.toJson()));
  }

  Future<ApiResult> resetPassword(ResetPasswordRequest request) async {
    return handleApiRequest(() =>
        dioClient.post(AuthApiPath.resetPassword, data: request.toJson()));
  }

  Future<ApiResult> register(RegisterRequest request) async {
    return handleApiRequest(
        () => dioClient.post(AuthApiPath.register, data: request.toJson()));
  }

  Future<ApiResult> confirmAndChangePassword(
      ChangePasswordRequest request) async {
    // Confirm old password and change password
    try {
      final res = await dioClient.post(AuthApiPath.confirmAndChangePassword,
          data: request.toJson());

      if (res is String) {
        // trường hợp be lỏd response json mà lại trả về dạng string
        BaseResponse response =
            BaseResponse.fromJson(jsonDecode(res) as Map<String, dynamic>);
        return ApiResult.apiSuccess(response);
      }

      BaseResponse response = BaseResponse.fromJson(res);
      return ApiResult.apiSuccess(response);
    } catch (e) {
      return ApiResult.apiFailure(NetworkExceptions.getDioException(e));
    }
  }
}
