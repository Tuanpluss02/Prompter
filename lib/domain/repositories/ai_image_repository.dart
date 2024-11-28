import 'dart:convert';

import 'package:base/domain/data/local/api_result.dart';
import 'package:base/domain/repositories/base_repository.dart';
import 'package:dio/dio.dart';

final class AiImageAPIPath {
  static const String ciciBaseUrl = 'https://www.ciciai.com';
  static const String ciciSkillPackEndpoint = '/samantha/skill/pack';
  static const String civitBaseUrl = 'https://civitai.com';
  static const String civitGetImageEndpoint = '/api/trpc/image.getInfinite';
  static const String civitGetDetailEndpoint = '/api/trpc/image.getGenerationData';
  static String civitImageUrl(String urlId, String id) => 'https://image.civitai.com/xG1nkqKTMzGDvpLrqFT7WA/$urlId/$id.jpeg';
  static const String seaArtBaseUrl = 'https://www.seaart.ai';
  static const String seaArtExploreEndpoint = '/api/v1/square/tag/explore';
}

class AiImageRepository extends BaseRepository {
  AiImageRepository() : super(baseUrl: '');
  static String? civitCursor;
  static int seaArtPage = 1;
  Future<ApiResult> getCiCiAiImages() {
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
          AiImageAPIPath.ciciBaseUrl + AiImageAPIPath.ciciSkillPackEndpoint,
          data: json.encode(data),
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ),
        ));
  }

  Future<ApiResult> getCivitAiDetail(int id) {
    var headers = {
      'accept': '*/*',
      'accept-language': 'vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7',
      'content-type': 'application/json',
      'cookie':
          '__stripe_mid=a76f7de3-7479-44c7-bc71-478b2c37b9b5e3e512; __Host-next-auth.csrf-token=ea166ad23cdbaf573847a76957b542a8b2b359e9f8bd6ea7b60d033ca90bf41a%7C040a2aff17b31d4273a9fce808f70e03d6163f88d4e60c9cdff0f58c6e52d132; __Secure-next-auth.callback-url=https%3A%2F%2Fcivitai.com; ref_landing_page=%2F; __Secure-civitai-token=eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIn0..a0syKaquukkujGn0.gHeuj53dehN5Dxppgjn8S4n5Mw29yX30HoDcUfsupewA1VPb-udBw9Ope4bfVv0ilrbk1LJi9RC9V4RvdttkxnBOGBtI6BC_tJ4ZFYic3QRbhQdkW3ttsEjLlD7uwBxk1UD8zeY3puihE0L5II1YV7wTbm32PiuESaPNsWtq8PLYgrEQ0MXQeO_R5n2nRPaInIK6xaJLMZ2ywjpfu2SefbZ4WKgRatVw8KROPv36ELInc_417UN1feVzqjip8rW__hAUUSawx48KRslIoqX-5Axvr9QR-Urbt8o75QWxwzJVtTUVKbgnCoeLlYxAhgr9V06zpMj3Fih9Lkea5RMroM54WSAHCbSh9UKCSFrYfpPgLc5qaQ32Xn-KnSfo1g4-Fj5MClJwgPTNpIyvjE4xL7lwoHdJGeBNrAJJjJUrpsu4_BzRbLVs3YlmBQihi-mQlvYkWk1N9vrWwLcWtcGzOd-qPKdmV-RtAUMBApNgej2McGe7q40JhqNIOzNxxiw_KOY8_xFbHQfZpK5nKRlG5rXAmeoMsLpaJfP-7ILfbgKvw3XmDM7WLkl6_gRGXoHSWx4_x05Nx5g7c1LrelxLmqX8BvuOQ9aB_iDC9rrOcecZgD898ZgF1cTxdNnWU93W7h04FHbeebRDPfrYGDTtGadfoUSBHOftBoi65cBPp79-my2LJevFo0cIrhXmU2S-0SPJJ1qoTPS6fk7yjPE-lOYDpFV47K82AL36PRxkCdLXuM-xRJLikOgoHKiIZuncrVycx_tN9bBZUrOrzLgD9-UbBIq_L9cSnNE2abgzoBVKXrwwCwh_odlbNwU5EdAeAp3ua3qJYAReFi9uTzI9acF7HyyjjddjmfHoUT65S1tIxCpmEXVkWl9CwQDN9yaPCvFVq80pirK7RG8dNzQRoptuOjdV-TVvCV-Sk3J0QoWGTyQkKMoLFNF-afIVZBb1AwxPpeoQTXbvqA._bGw45yQ7etq5vIT97EOOg; __Secure-civitai-token=eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIn0..46AMQRb4vKHzc5D1.31nER56ltzt5BzpX6x_jn1pMXQyQXhgrhlPeYZsiCf7Np5xFZhGXyH3lFCS2hELc3q8MLcnLnHge1DvHNpTJKShVWEa5Yaaxh9mOkTuoRzUWUdBBAqfeTiye-lTVXtgx6cznf2c2yD1FBnn7B6rnneh_XT0UnZi7phWZhXE_9UhynsjELN-1pxF9av3-WZYZ27oYZDah1i_E22TFWlyTDA6bAsqh-8mm0eeUTH3wVVlqjQlJuRjdE_draSUJhGIqlr82u6v-bKtCiHxJAsZPxpFLRxsvUD2Z_A7xSsVusGDylSbqbHLYjdbpZWxsig-xGNAwgcKuf61ig1U_F2Llnj19t7ei2oFkbhghR4R94n8VGg5jlHWCueb3aii9E6qS5vDCXAordapzaIp7WT0LBumTQqWXg8vIFasoORVQ6igJsEKJU4gq5YAdb4wq7o9dbxE78xTjdcYefSevmBFpI08pTQXjzSOh3ZSsdoJq3g4DCCZ_WW_qKmeIB-8GbOaE4KrdhyrukIrRKOmlkaUA3i3fjKRH4eLWdfbhLwhLQCaZGLVZBrTSg8i8Hk0AaQGTJ7YdEtx7ZT_n93Ay1V8rAcvtRjjDJZ1dfHhikA3P0zK_w4ospywhustUO8yw2XN1JmXjASsgxdM06vIVbT6RAX1Y543PlQwv3rKiEXgT4UHA3B2P7EeQ2vvvAKR5dgEQjOajEeVyzoekFSG6OOc5bj2KmpJdizGTlIRJ5s37fGa7JCK887v1U88uh6bF648dyw3bzaYCrspju8MMY9SXulyAP7MdA58JrJ5YneKvNkkebmZ7dVU_CP69C2mpCso0cc1t174NUBA7WWx5y19v4D4U5LBM_oTuO1mZ1PkNgi9iFoAI6pLRN6RZdmNfgOY2nuJixKIMchsUjlbND2261np7drjwgFa3yeEnPP-WDlZESpmkTDeS-2fcL6uNCO_djF--2s17RnlRkA.GlpWJgY5r0x1hCPY6pAAAA',
      'priority': 'u=1, i',
      'referer': 'https://civitai.com/images/41336897',
      'sec-ch-ua': '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      'x-client': 'web',
      'x-client-date': '1732697475290',
      'x-client-version': '5.0.310',
      'x-fingerprint': '94430791b589557338ff622a98d080075e0e16e435093f68357f8d23a0cac822e51e778f4d295ed7f086586a40abbf6e'
    };
    Map<String, dynamic> params(int id) => {
          "input": {
            "json": {
              "id": id,
              "authed": true,
            }
          }
        };
    final encodedParams = params(id).map((key, value) => MapEntry(key, jsonEncode(value)));
    return handleApiRequestCustomResponse(() => dioClient.get(
          AiImageAPIPath.civitBaseUrl + AiImageAPIPath.civitGetDetailEndpoint,
          queryParameters: encodedParams,
          options: Options(
            headers: headers,
          ),
        ));
  }

  Future<ApiResult> getCivitAiImages() {
    var headers = {
      'accept': '*/*',
      'accept-language': 'vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7',
      'content-type': 'application/json',
      'cookie':
          '__stripe_mid=a76f7de3-7479-44c7-bc71-478b2c37b9b5e3e512; __Host-next-auth.csrf-token=ea166ad23cdbaf573847a76957b542a8b2b359e9f8bd6ea7b60d033ca90bf41a%7C040a2aff17b31d4273a9fce808f70e03d6163f88d4e60c9cdff0f58c6e52d132; __Secure-next-auth.callback-url=https%3A%2F%2Fcivitai.com; ref_landing_page=%2F; __Secure-civitai-token=eyJhbGciOiJkaXIiLCJlbmMiOiJBMjU2R0NNIn0..Hei9Fe-ncQQewIPc.UU1ki-2bgYP3DQ3RYE2cypYC5HG2h0X56TrAwWbsTjDqPpjXfGS-qRSsMFw4H9HVn3lp0Y5AZarf-ut5rzCvZ9HiFt0zV3Ei69Zp_hv50Nepiy-7T1Dq8OzfPoBa3Owv7RqqgFiwLGK0_qdboZgVDkXUfxJiIthR1L73WSoL0Cr3Tds8dphLMIAoC8r1CznpINknnjDYp39-QcXgXHQdEH67W8At6gYEaOTrhfr0gQoMNflUjG4Kx8MTKmAMPA-a8p237Qo--B6wojYyFM2Kp8KeWcgwbX0Y43aeuvZexu_5PPygv1B5a7JEo6lDRrKc0gh-E_CrlAHRjXNRlsRN9xt4nob7HH7ogbXPAPy951TC1f9GsZ2p0aSQLVywf3cxZNiBtmgn-veZhID1OM7luCQ8VCpBFB8PGpIoUjKb8B8QCbisFSFqbunNLYfh0SxSoGtb9GnQ508UgfjHQnxYIJlEKAUd-sP9ZYvCCdaGCoiDZvNenfwY2_sSgSExpuVw7dDcMdOTO2a-owBuUJfE7OzZLtuIxLrtr72_zA6K_cn35QF8_isOsLFp3yTPU_k9XiL_dmI2G21TCxgvVCJDMnrnuXCr_Jh9J6I09y-4jaX1bcP8BnaDaQdWZhEHIjnr7WR6w7f73J_9gaPWVn9Ltof3PO8xVNO3Vqrt3iHU-Rj7exfCwv9jJvqHIqh0Oe34cwX8XjfmBDVuLaPOWXRqagjFAdB7l97NdJDA1fUHcTl460XWjWxhu14veXJclvcme2n76Sp0K5UycOaq2uzfUKuiKT3yygpJ1v9lYRSUyX3_T01aqzsdkXd0dmL1lvSkquaL4f59PJneq4ulViAdrJNQcvHy3rGdhrxkNHWrwN1seE1ILwJG3G247LcD6q4tFPgE4B0Z1hT8qekqhq3cbcsTkNTgS3zZtPi9IpunH-F1Cpa91oVR2LDxj5z1pi1uuenLd3ucJxSplQ.btgnE-kou_t9YIGcy4rakw',
      'if-modified-since': 'Wed, 27 Nov 2024 08:41:47 GMT',
      'priority': 'u=1, i',
      'referer': 'https://civitai.com/images',
      'sec-ch-ua': '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      'x-client': 'web',
      'x-client-date': '1732697073361',
      'x-client-version': '5.0.310',
      'x-fingerprint': '94430791b589557338ff622a98d080075e0e16e435093f68357f8d23a0cac822e51e778f4d295ed7f086586a40abbf6e'
    };
    final Map<String, dynamic> params = {
      "input": {
        "json": {
          "period": "Week",
          "sort": "Most Reactions",
          "types": ["image"],
          "useIndex": true,
          "browsingLevel": 1,
          "include": ["cosmetics"],
          "cursor": civitCursor,
          "authed": true,
        },
        "meta": {
          "values": {
            "cursor": ["undefined"],
          },
        },
      }
    };
    final encodedParams = params.map((key, value) => MapEntry(key, jsonEncode(value)));
    return handleApiRequestCustomResponse(() => dioClient.get(
          AiImageAPIPath.civitBaseUrl + AiImageAPIPath.civitGetImageEndpoint,
          queryParameters: encodedParams,
          options: Options(
            headers: headers,
          ),
        ));
  }

  Future<ApiResult> getSeaArtImages() {
    var headers = {
      'accept': 'application/json, text/plain, */*',
      'accept-language': 'en',
      'content-type': 'application/json',
      'cookie': 'deviceId=00da29c4-aad9-4b2c-b802-9e8d201faf10; enable_tavern_visitor=2; browserId=5c4a033b9c0ae3061e925693d3c193d9; enable_tavern_user=; pageId=e3670511-0dfe-44bc-bd8e-2eab39d18719',
      'origin': 'https://www.seaart.ai',
      'priority': 'u=1, i',
      'referer': 'https://www.seaart.ai/tagInfo/landscape',
      'sec-ch-ua': '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"macOS"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
      'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36',
      'x-app-id': 'web_global_seaart',
      'x-browser-id': '5c4a033b9c0ae3061e925693d3c193d9',
      'x-device-id': '00da29c4-aad9-4b2c-b802-9e8d201faf10',
      'x-page-id': 'e3670511-0dfe-44bc-bd8e-2eab39d18719',
      'x-platform': 'web',
      'x-request-id': '83f287dc-4e8b-4093-a421-9992cefa5f77'
    };
    var data = json.encode({
      "tag": "landscape",
      "page": seaArtPage,
      "page_size": 50,
      "order_by": "hot",
      "content_type": [1],
      "window_code": "square:tag:detail:explore",
      "time_from": 1732173891517,
      "time_to": 1732778691517,
      "is_dft": 1,
      "offset": 1732778691111,
      "nodes_type": []
    });
    return handleApiRequestCustomResponse(() => dioClient.post(
          '${AiImageAPIPath.seaArtBaseUrl}${AiImageAPIPath.seaArtExploreEndpoint}',
          data: data,
          options: Options(
            headers: headers,
          ),
        ));
  }
}
