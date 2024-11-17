import 'dart:convert';

import 'package:base/domain/data/local/api_result.dart';
import 'package:base/domain/repositories/base_repository.dart';
import 'package:dio/dio.dart';

final class CiciAPIPath {
  static const String baseUrl = 'https://www.ciciai.com';
  static const String skillPackEndpoint = '/samantha/skill/pack';
}

class CiciRepository extends BaseRepository {
  CiciRepository() : super(baseUrl: CiciAPIPath.baseUrl);

  Future<ApiResult> getAiImages() async {
    Map<String, String> headers = {
      'accept': 'application/json, text/plain, */*',
      'accept-language': 'vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7',
      'content-type': 'application/json',
      'cookie':
          'passport_csrf_token=0e11e0ad0e7bd14756dd9064b449e044; passport_csrf_token_default=0e11e0ad0e7bd14756dd9064b449e044; is_staff_user=false; store-idc=alisg; store-country-code=vn; store-country-code-src=uid; s_v_web_id=verify_m3g4aey2_pMDbOpdb_eYJt_4iVZ_9U5R_oX74Wix9mJ2n; oauth_token=df58b2b9-ba7a-4049-8e9d-5ab602e88804; uid_tt=dbbac47d23639f0aae5b244ee2e4f2dc37708fbe44b1c478582b3bc2e8079b0c; uid_tt_ss=dbbac47d23639f0aae5b244ee2e4f2dc37708fbe44b1c478582b3bc2e8079b0c; sid_tt=18254d3338d98932bee0c43679e0929f; sessionid=18254d3338d98932bee0c43679e0929f; sessionid_ss=18254d3338d98932bee0c43679e0929f; ttwid=1%7CzL7tRVIXcEw1zwxHNl6_T7JvqCpnRlInztXlR-CLxds%7C1731516641%7C41dae1bc2b850248784225eaf9acb4076258da51cd8d146d56cb122aa26911fb; passport_csrf_token_wap_state=6cfb3bac3gAToVCgoVPZIDE4MjU0ZDMzMzhkOTg5MzJiZWUwYzQzNjc5ZTA5MjlmoU6goVYBoUkAoUQAoUHSAAeQN6FNAKFIrnd3dy5jaWNpYWkuY29toVIColBM0QglpkFDVElPTqChTNmpaHR0cHM6Ly93d3cuY2ljaWFpLmNvbS9jaGF0L2NyZWF0ZS1pbWFnZT9mcm9tX2xvZ2luPTEmb3JpZ2luX2xhbmRpbmc9aHR0cHMlM0ElMkYlMkZ3d3cuY2ljaWFpLmNvbSUyRiUzRmZyb21fbG9nb3V0JTNEMSUyNmxvZ2luU3VjY2Vzc0JhY2tVcmwlM0QlMjUyRmNoYXQlMjUyRmNyZWF0ZS1pbWFnZaFU2SA2MjRjYjM2MTIzYjdkZDEwNmRjODEzM2Q3MGY0NmJhYaFXAKFGAKJTQQChVcKiTUzC; odin_tt=abc5309178fce8acaae3ec654ee5b641b4c844b400416a210e8ee3f5a660efdb8aef30b62c0220a40281f9da88407cac96120d47842b109ed58f80be447b0256; passport_auth_status=3420f4e3b6a360412448457986c7c7c0%2C56f250f625a7542df5009550d749d244; passport_auth_status_ss=3420f4e3b6a360412448457986c7c7c0%2C56f250f625a7542df5009550d749d244; sid_guard=18254d3338d98932bee0c43679e0929f%7C1731516643%7C5183999%7CSun%2C+12-Jan-2025+16%3A50%3A42+GMT; sid_ucp_v1=1.0.0-KGFkNmNjYWY5YTllZjA0MWM5MDlmOTkyMjQ3MTNjMTk3NmYwOGUxNGEKIAiHiJDKlNuUh2YQ47HTuQYYt6AeIAwwiKa5sAY4CEASEAMaA3NnMSIgMTgyNTRkMzMzOGQ5ODkzMmJlZTBjNDM2NzllMDkyOWY; ssid_ucp_v1=1.0.0-KGFkNmNjYWY5YTllZjA0MWM5MDlmOTkyMjQ3MTNjMTk3NmYwOGUxNGEKIAiHiJDKlNuUh2YQ47HTuQYYt6AeIAwwiKa5sAY4CEASEAMaA3NnMSIgMTgyNTRkMzMzOGQ5ODkzMmJlZTBjNDM2NzllMDkyOWY; passport_fe_beating_status=true; msToken=0Ckfe8hbwpGQE1x0fT_4tRqENKdRqCd0EqCzae9XNUudmDzG_aafikvx8wPy2SjIO6sHfQeadrAh2mpWkBLYj607ubh1czztAiQlXuByvqzkaXw-XoqZ5ApUa7hJ_0Mg; msToken=0Ckfe8hbwpGQE1x0fT_4tRqENKdRqCd0EqCzae9XNUudmDzG_aafikvx8wPy2SjIO6sHfQeadrAh2mpWkBLYj607ubh1czztAiQlXuByvqzkaXw-XoqZ5ApUa7hJ_0Mg',
      'origin': 'https://www.ciciai.com',
      'priority': 'u=1, i',
      'referer': 'https://www.ciciai.com/chat/create-image?from_login=1&origin_landing=https%3A%2F%2Fwww.ciciai.com%2F%3Ffrom_logout%3D1%26loginSuccessBackUrl%3D%252Fchat%252Fcreate-image',
      'sec-ch-ua': '"Google Chrome";v="129", "Not=A?Brand";v="8", "Chromium";v="129"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Linux"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36'
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
      'msToken': '0Ckfe8hbwpGQE1x0fT_4tRqENKdRqCd0EqCzae9XNUudmDzG_aafikvx8wPy2SjIO6sHfQeadrAh2mpWkBLYj607ubh1czztAiQlXuByvqzkaXw-XoqZ5ApUa7hJ_0Mg',
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
