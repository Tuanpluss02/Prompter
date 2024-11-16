import 'dart:convert';
import 'dart:typed_data';

import 'package:base/app/constants/app_enums.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:http/http.dart' as http;

final class HuggingfaceAPIPath {
  static const String baseUrl = 'https://api-inference.huggingface.co/models';
}

class HuggingfaceRepository extends BaseRepository {
  HuggingfaceRepository() : super(baseUrl: HuggingfaceAPIPath.baseUrl);
  final headers = {
    'Authorization': 'Bearer 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',
    'Content-Type': 'application/json',
  };

  Future<Uint8List?> generateImage(String prompt, GenerativeAiModel model) async {
    final response = await http.post(
      Uri.parse('${HuggingfaceAPIPath.baseUrl}/${model.modelId}'),
      headers: headers,
      body: json.encode({'inputs': prompt}),
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    return null;
  }
}
