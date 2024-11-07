import 'package:base/data/local/api_result.dart';
import 'package:base/data/local/network_exceptions.dart';
import 'package:base/data/responses/base_response.dart';
import 'package:base/services/dio_client.dart';
import 'package:dio/dio.dart';

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
