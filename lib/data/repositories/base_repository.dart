import 'package:dio/dio.dart';
import 'package:base/data/models/response/base_response.dart';
import 'package:base/services/api_result.dart';
import 'package:base/services/dio_client.dart';
import 'package:base/services/network_exceptions.dart';

class BaseRepository {
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
      return ApiResult.apiSuccess(response);
    } catch (e) {
      final error = NetworkExceptions.getDioException(e);
      return ApiResult.apiFailure(error);
    }
  }
}
