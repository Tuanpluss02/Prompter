import 'package:base/app/utils/snackbar.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/repositories/huggingface_repository.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiChatController extends BaseController {
  final HuggingfaceRepository _huggingfaceRepository = HuggingfaceRepository();

  final ChatController chatController = ChatController(
      initialMessageList: [
        Message(
            message: 'Hello, I am AI. How can I help you?',
            sentBy: '2',
            createdAt: DateTime.now()),
      ],
      currentUser: ChatUser(name: 'User', id: '1'),
      scrollController: ScrollController(),
      otherUsers: [
        ChatUser(name: 'AI', id: '2'),
      ]);
  var chatViewState = ChatViewState.hasMessages.obs;

  var image = Image(
          image: NetworkImage(
              'https://cdn-media.sforum.vn/storage/app/media/wp-content/uploads/2023/12/hinh-nen-vu-tru-72.jpg'))
      .obs;

  Future<void> generateImage(String prompt) async {
    final result = await _huggingfaceRepository.generateImageCustomResponse(
        prompt, ImageGenerateModel.stableDiffusion);
    if (result == null) {
      showSnackBar(title: 'Generate image failed', type: SnackBarType.error);
      return;
    }
    image.value = Image.memory(result);
  }
}

Uint8List stringToUint8List(String data) {
  return Uint8List.fromList(data.codeUnits);
}
