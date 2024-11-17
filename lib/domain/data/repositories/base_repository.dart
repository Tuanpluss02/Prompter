import 'package:base/domain/data/local/api_result.dart';
import 'package:base/domain/data/local/network_exceptions.dart';
import 'package:base/domain/data/responses/base_response.dart';
import 'package:base/domain/services/dio_client.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  late DioClient dioClient;
  final String baseUrl;

  BaseRepository({required this.baseUrl}) {
    var dio = Dio();
    dioClient = DioClient(dio, baseUrl: baseUrl);
  }

  Future<ApiResult> handleApiRequest(Future<dynamic> Function() request) async {
    try {
      final res = await request();
      BaseResponse response = BaseResponse.fromJson(res);
      return ApiResult.success(response);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return ApiResult.failure(error);
    }
  }

  Future<ApiResult> handleApiRequestCustomResponse(Future<dynamic> Function() request) async {
    try {
      final response = await request();
      return ApiResult.successWWithCustomResponse(response);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return ApiResult.failure(error);
    }
  }
}
