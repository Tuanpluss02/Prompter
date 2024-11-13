import 'dart:convert';

import 'package:base/data/local/api_result.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:dio/dio.dart';

final class CiciAPIPath {
  static const String baseUrl = 'https://www.ciciai.com';
  static const String skillPackEndpoint = '/samantha/skill/pack';
}

class CiciRepository extends BaseRepository {
  CiciRepository() : super(baseUrl: CiciAPIPath.baseUrl);

  Future<ApiResult> getAiImages() async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'content-type': 'application/json',
    };

    Map<String, String> queryParameters = {
      'version_code': '20710',
      'language': 'en',
      'device_platform': 'web',
      'aid': '495671',
      'real_aid': '495671',
      'pkg_type': 'release_version',
      'device_id': '7424896809073772033',
      'web_id': '7424896863613109778',
      'tea_uuid': '7424896863613109778',
      'use-olympus-account': '1',
      'region': 'US',
      'sys_region': 'US',
      'samantha_web': '1',
      'msToken':
          '0Ckfe8hbwpGQE1x0fT_4tRqENKdRqCd0EqCzae9XNUudmDzG_aafikvx8wPy2SjIO6sHfQeadrAh2mpWkBLYj607ubh1czztAiQlXuByvqzkaXw-XoqZ5ApUa7hJ_0Mg',
      'X-Bogus': 'DFSzswVYFXblhP4jtKDW7t4l0Tbj',
      '_signature': '_02B4Z6wo00001CEmvoAAAIDAESnGFuFWv-ghJroAAG-Ed6',
    };

    Map<String, dynamic> data = {
      "skill_type": 3,
      "condition": {
        "image_condition": {"category_id": 0}
      }
    };
    return handleApiRequest(() => dioClient.post(
          CiciAPIPath.skillPackEndpoint,
          data: json.encode(data),
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        ));
  }
}
