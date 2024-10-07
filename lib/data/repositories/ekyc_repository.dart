import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:base/app/constants/app_strings.dart';
import 'package:base/data/models/request/update_ekyc_request.dart';
import 'package:base/data/models/response/base_response.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:base/services/network_exceptions.dart';

import '../../services/api_result.dart';

class EkycRepository extends BaseRepository {
  EkycRepository() : super(baseUrl: 'http://172.16.90.85:8801');

  Future<ApiResult> getTokenEkyc() async {
    try {
      final res = await dioClient.get(
        '/api/68b4c717/ekyc/login',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppStrings.authorizationEKYC}',
          },
        ),
      );
      BaseResponse response = BaseResponse.fromJson(res);
      return ApiResult.apiSuccess(response);
    } catch (e) {
      return ApiResult.apiFailure(NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult> updateEkyc(UpdateEkycRequest param) async {
    try {
      final res = await dioClient.post(
        '/api/app/profile/update/ekyc',
        data: param.toJson(),
      );
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
