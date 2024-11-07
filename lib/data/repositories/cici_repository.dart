import 'dart:convert';

import 'package:base/data/local/api_result.dart';
import 'package:base/data/local/network_exceptions.dart';
import 'package:base/data/responses/base_response.dart';
import 'package:dio/dio.dart';

class CiciRepository {
  // CiciRepository() : super(baseUrl: '');

  Future<ApiResult> getAiImages() async {
    var headers = {
      'accept': 'application/json, text/plain, */*',
      'accept-language': 'vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7',
      'content-type': 'application/json',
      'cookie':
          'store-idc=alisg; store-country-code=vn; store-country-code-src=uid; oauth_token=9588f8dd-9d6f-46f2-9d4d-8aa612ad992b; s_v_web_id=verify_m31x8a3z_whIu02Ia_SZx9_4SN4_8X9t_JHqajtCPPgIB; passport_csrf_token=39141bda4386a387ea353107b6af95b1; passport_csrf_token_default=39141bda4386a387ea353107b6af95b1; passport_csrf_token_wap_state=22d7dab73gAToVCgoVPZIGIzYzY5OTQ3MmVjODNiMjZhNTJiOGRkMTFjZWJiMTFioU6goVYBoUkAoUQAoUHSAAeQN6FNAKFIrnd3dy5jaWNpYWkuY29toVIColBM0QglpkFDVElPTqChTNkkaHR0cHM6Ly93d3cuY2ljaWFpLmNvbS9hdXRoL2NhbGxiYWNroVTZIGY3NGU2ZGI0MzcxMTgzNmQ5ZGY0ZDgyNzliM2QwMzY1oVcAoUYAolNBAKFVwqJNTMI%253D; odin_tt=9fe892f0996ba95e26044e99719a3eac532788bd3dcdcf214dfb8cff229092b49ed65ead10d4d358d2e173f109d8d18543c155c63e1fb910161984f46d2a464d; passport_auth_status=2934fbb50771d447f28816acd0d4bcdb%2C; passport_auth_status_ss=2934fbb50771d447f28816acd0d4bcdb%2C; sid_guard=5097fa483b55a3b724fabb707f79199d%7C1730658237%7C5184000%7CThu%2C+02-Jan-2025+18%3A23%3A57+GMT; uid_tt=9d9164b62b435085e6a1ebb463650d2199f95e5e8407dc8e24d1f1e9be35bc7d; uid_tt_ss=9d9164b62b435085e6a1ebb463650d2199f95e5e8407dc8e24d1f1e9be35bc7d; sid_tt=5097fa483b55a3b724fabb707f79199d; sessionid=5097fa483b55a3b724fabb707f79199d; sessionid_ss=5097fa483b55a3b724fabb707f79199d; is_staff_user=false; sid_ucp_v1=1.0.0-KDg2ZTUxMWYzZDM3Y2FiNTVjNTUxNDcxOWQ2ODM4MjJiMzdlZGNjMTMKIAiHiJDKlNuUh2YQvf-euQYYt6AeIAwwiKa5sAY4CEASEAMaA3NnMSIgNTA5N2ZhNDgzYjU1YTNiNzI0ZmFiYjcwN2Y3OTE5OWQ; ssid_ucp_v1=1.0.0-KDg2ZTUxMWYzZDM3Y2FiNTVjNTUxNDcxOWQ2ODM4MjJiMzdlZGNjMTMKIAiHiJDKlNuUh2YQvf-euQYYt6AeIAwwiKa5sAY4CEASEAMaA3NnMSIgNTA5N2ZhNDgzYjU1YTNiNzI0ZmFiYjcwN2Y3OTE5OWQ; ttwid=1%7CFMkNWKVcmHz5PVvc1iCZjRv4dAzwkd-RPlSLFKCOIxY%7C1730658341%7C2146a9e443fbb55d3f34fd8997afcdc4baed3251e6ee38d25b98200fd0edd52f; passport_fe_beating_status=true; msToken=llSQa3LBHnarsrIWJO1v9vcSfIXf484pIXaZPYpNl1gYjJ_JXr55mXVImydSHb2GJTjz_mGKN21t-Tbb3o-OSLD5CCv8YcrrVEE22pnwCkQQ6wVc9Z3HLj9-SweO5Bc=; msToken=llSQa3LBHnarsrIWJO1v9vcSfIXf484pIXaZPYpNl1gYjJ_JXr55mXVImydSHb2GJTjz_mGKN21t-Tbb3o-OSLD5CCv8YcrrVEE22pnwCkQQ6wVc9Z3HLj9-SweO5Bc=',
      'origin': 'https://www.ciciai.com',
      'priority': 'u=1, i',
      'referer': 'https://www.ciciai.com/chat/create-image',
      'sec-ch-ua': '"Chromium";v="130", "Google Chrome";v="130", "Not?A_Brand";v="99"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36'
    };
    var data = json.encode({
      "skill_type": 3,
      "condition": {
        "image_condition": {"category_id": 0}
      }
    });
    var dio = Dio();
    return await handleApiRequest(() => dio.request(
          'https://www.ciciai.com/samantha/skill/pack?version_code=20710&language=vi&device_platform=web&aid=495671&real_aid=495671&pkg_type=release_version&device_id=7336076071664485890&web_id=7336076075816044033&tea_uuid=7336076075816044033&use-olympus-account=1&region=VN&sys_region=VN&samantha_web=1&msToken=llSQa3LBHnarsrIWJO1v9vcSfIXf484pIXaZPYpNl1gYjJ_JXr55mXVImydSHb2GJTjz_mGKN21t-Tbb3o-OSLD5CCv8YcrrVEE22pnwCkQQ6wVc9Z3HLj9-SweO5Bc=&X-Bogus=DFSzswVuV9hlhON8ts8hGShPmk39&_signature=_02B4Z6wo00001pjVutgAAIDC6wj4efN-DTaY1b5AAMEece',
          options: Options(
            method: 'POST',
            headers: headers,
          ),
          data: data,
        ));
  }
}

Future<ApiResult> handleApiRequest(Future<dynamic> Function() request) async {
  try {
    final res = await request();
    BaseResponse response = BaseResponse.fromJson(res.data);
    return ApiResult.apiSuccess(response);
  } catch (e) {
    final error = NetworkExceptions.getDioException(e);
    return ApiResult.apiFailure(error);
  }
}
