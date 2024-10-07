import 'package:dio/dio.dart';
import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/local/app_storage.dart';
import 'package:base/data/models/request/excall_e_contact_request.dart';
import 'package:base/data/models/response/create_e_contact_response.dart';
import 'package:base/data/models/response/template_e_contact.dart';
import 'package:base/services/api_result_e_contact.dart';
import 'package:base/services/dio_client.dart';
import 'package:base/services/network_exceptions_e_contact.dart';

import '../models/response/base_response.dart';
import 'base_repository.dart';

class EContactPath {
  static String baseUrlEContact = 'https://demo.econtract.fpt.com/app';
  static String tokenEContact = '/api/68b4c717/econtract/login';
  static String templateEContact =
      '/services/envelope/api/external/v1/template/structue?alias=HDMTK';
  static String createEContact = '/services/excall/api/excall';
}

class EContactRepository extends BaseRepository {
  EContactRepository() : super(baseUrl: 'http://172.16.90.85:8801');

  Future<ApiResultEContact<BaseResponse>> getTokenEContact(id) async {
    try {
      DioClient client = DioClient(Dio(),
          baseUrl: baseUrl, token: AppStrings.authorizationEKYC, id: id);
      final res = await client.get(EContactPath.tokenEContact);
      BaseResponse response = BaseResponse.fromJson(res);
      return ApiResultEContact.success(response);
    } catch (e) {
      final error = NetworkExceptionsEContact.getDioException(e);
      return ApiResultEContact.failure(error);
    }
  }

  Future<ApiResultEContact<TemplateEContact>> getTemplateEContact() async {
    try {
      DioClient dioClient = DioClient(Dio(),
          baseUrl: EContactPath.baseUrlEContact,
          token: AppStorage.getString(SharedPreferencesKeys.tokenEContact));
      final res = await dioClient.get(EContactPath.templateEContact);
      TemplateEContact response = TemplateEContact.fromJson(res);
      return ApiResultEContact.success(response);
    } catch (e) {
      final error = NetworkExceptionsEContact.getDioException(e);
      return ApiResultEContact.failure(error);
    }
  }

  Future<ApiResultEContact<CreateEContactResponse>> createEContact(
      ExcallEContactRequest request) async {
    try {
      DioClient dioClient = DioClient(Dio(),
          baseUrl: EContactPath.baseUrlEContact,
          token: AppStorage.getString(SharedPreferencesKeys.tokenEContact));
      final res = await dioClient.post(EContactPath.createEContact,
          data: request.toJson());
      CreateEContactResponse response = CreateEContactResponse.fromJson(res);
      return ApiResultEContact.success(response);
    } catch (e) {
      final error = NetworkExceptionsEContact.getDioException(e);
      return ApiResultEContact.failure(error);
    }
  }
}
