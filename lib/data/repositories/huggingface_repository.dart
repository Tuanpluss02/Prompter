import 'dart:convert';
import 'dart:typed_data';

import 'package:base/data/local/api_result.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

final class HuggingfaceAPIPath {
  static const String baseUrl = 'https://api-inference.huggingface.co/models';
}

enum ImageGenerateModel {
  midjourney('Jovie/Midjourney'),
  stableDiffusion('stabilityai/stable-diffusion-3.5-large');

  final String value;

  const ImageGenerateModel(this.value);
}

class HuggingfaceRepository extends BaseRepository {
  HuggingfaceRepository() : super(baseUrl: HuggingfaceAPIPath.baseUrl);
  final headers = {
    'Authorization': 'Bearer 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',
    'Content-Type': 'application/json',
  };
  Future<ApiResult> generateImage(
      String prompt, ImageGenerateModel model) async {
    return handleApiRequestCustomResponse(() => dioClient.post(
          '/${model.value}',
          data: {'inputs': prompt},
          options: Options(headers: headers),
        ));
  }

  Future<Uint8List?> generateImageCustomResponse(
      String prompt, ImageGenerateModel model) async {
    final response = await http.post(
      Uri.parse('${HuggingfaceAPIPath.baseUrl}/${model.value}'),
      headers: headers,
      body: json.encode({'inputs': prompt}),
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }
}
