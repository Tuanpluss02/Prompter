import 'package:base/app/utils/snackbar.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/repositories/huggingface_repository.dart';
import 'package:base/services/cloudinary_service.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AiChatController extends BaseController {
  final HuggingfaceRepository _huggingfaceRepository = HuggingfaceRepository();
  final CloudinaryService _cloudinaryService = CloudinaryService();

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

  Future<Uint8List?> generateImage(String prompt) async {
    final result = await _huggingfaceRepository.generateImage(
        prompt, ImageGenerateModel.stableDiffusion);
    if (result == null) {
      showSnackBar(title: 'Generate image failed', type: SnackBarType.error);
      return null;
    }
    return result;
  }

  void onTapSend(String message, ReplyMessage replyMessage,
      MessageType messageType) async {
    chatController.addMessage(
      Message(
        message: message,
        sentBy: chatController.currentUser.id,
        createdAt: DateTime.now(),
        messageType: messageType,
        replyMessage: replyMessage,
      ),
    );
    if (messageType == MessageType.text) {
      Uint8List? img = await generateImage(message);
      if (img == null) {
        showSnackBar(title: 'Generate image failed', type: SnackBarType.error);
        return;
      }
      final response = await _cloudinaryService.uploadImage(img);
      if (response == null) {
        showSnackBar(title: 'Upload image failed', type: SnackBarType.error);
        return;
      }
      chatController.addMessage(
        Message(
          message: response,
          sentBy: chatController.otherUsers.first.id,
          createdAt: DateTime.now(),
          messageType: MessageType.image,
        ),
      );
    }
  }
}

Uint8List stringToUint8List(String data) {
  return Uint8List.fromList(data.codeUnits);
}
