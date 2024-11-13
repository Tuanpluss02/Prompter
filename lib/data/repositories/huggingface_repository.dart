import 'package:base/data/local/api_result.dart';
import 'package:base/data/repositories/base_repository.dart';
import 'package:dio/dio.dart';

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
  final header = {
    'Authorization': 'Bearer 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',
    'Content-Type': 'application/json',
  };
  Future<ApiResult> generateImage(String prompt, ImageGenerateModel model) {
    return handleApiRequest(() => dioClient.post(
          '/${model.value}',
          data: {'inputs': prompt},
          options: Options(headers: header),
        ));
  }
}
