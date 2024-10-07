import 'dart:io';

import 'package:dio/dio.dart';
import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/models/request/add_bank_account_request.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/api_result.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class ProfileApiPath {
  static String getBalance = '/balance';
  static String updateAvatar = '/update/avatar';
  static String addBankAccount = '/add/bank_account';
  static String bankAccounts = '/bank_accounts';
}

class ProfileRepository extends BaseRepository {
  ProfileRepository() : super(baseUrl: AppStrings.baseUrlProfile);

  Future<ApiResult> getBalance() async {
    return handleApiRequest(() => dioClient.get(ProfileApiPath.getBalance));
  }

  Future<ApiResult> getProfile() async {
    return handleApiRequest(() => dioClient.get(''));
  }

  Future<ApiResult> addBankAccount(
      AddBankAccountRequest addBankAccountRequest) async {
    return handleApiRequest(() => dioClient.post(ProfileApiPath.addBankAccount,
        data: addBankAccountRequest.toJson()));
  }

  Future<ApiResult> getProfileBankAccount() async {
    return handleApiRequest(() => dioClient.get(
          ProfileApiPath.bankAccounts,
        ));
  }

  Future<ApiResult> updateAvatar(File file) async {
    final mimeType = lookupMimeType(file.path);
    var type = mimeType?.substring(mimeType.indexOf('/') + 1);
    String fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', '$type')),
    });
    return handleApiRequest(
        () => dioClient.put(ProfileApiPath.updateAvatar, data: formData));
  }
}
