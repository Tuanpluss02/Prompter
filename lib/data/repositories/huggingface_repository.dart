import 'dart:convert';
import 'dart:typed_data';

import 'package:base/data/repositories/base_repository.dart';
import 'package:http/http.dart' as http;

final class HuggingfaceAPIPath {
  static const String baseUrl = 'https://api-inference.huggingface.co/models';
}

enum ImageGenerateModel {
  midjourney('Jovie/Midjourney', 'Midjourney', 'https://upload.wikimedia.org/wikipedia/commons/2/24/Midjourney_Emblem.svg'),
  stableDiffusion('stabilityai/stable-diffusion-3.5-large', 'Stable Diffusion', 'https://images.prismic.io/encord/Zeb6euXgT-BdbvJy_image-47-.png?auto=format%2Ccompress&fit=max');

  final String modelId;
  final String displayName;
  final String avatarUrl;

  const ImageGenerateModel(this.modelId, this.displayName, this.avatarUrl);
}

class HuggingfaceRepository extends BaseRepository {
  HuggingfaceRepository() : super(baseUrl: HuggingfaceAPIPath.baseUrl);
  final headers = {
    'Authorization': 'Bearer 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',
    'Content-Type': 'application/json',
  };

  Future<Uint8List?> generateImage(String prompt, ImageGenerateModel model) async {
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
