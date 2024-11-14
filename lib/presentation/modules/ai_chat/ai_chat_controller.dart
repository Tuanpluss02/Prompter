import 'package:base/base/base_controller.dart';
import 'package:base/data/repositories/huggingface_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

class AiChatController extends BaseController {
  final HuggingfaceRepository _huggingfaceRepository = HuggingfaceRepository();
  var image = Image(
          image: NetworkImage(
              'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/12/hinh-nen-vu-tru-72.jpg'))
      .obs;

  Future<void> generateImage(String prompt) async {
    final result = await _huggingfaceRepository.generateImage(
        prompt, ImageGenerateModel.stableDiffusion);
    result.whenOrNull(
      successWWithCustomResponse: (res) {
        Uint8List data = stringToUint8List(res);
        image.value = Image.memory(
            Uint8List.fromList(img.encodePng(img.decodeImage(data)!)));
      },
      failure: (error) {
        print(error);
      },
    );
  }
}

Uint8List stringToUint8List(String data) {
  return Uint8List.fromList(data.codeUnits);
}
