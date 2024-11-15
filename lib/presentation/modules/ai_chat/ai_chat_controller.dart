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

  late final ChatController chatController;
  var chatViewState = ChatViewState.hasMessages.obs;
  var selectedModel = ImageGenerateModel.stableDiffusion.obs;

  @override
  void onInit() {
    chatController = ChatController(
        initialMessageList: [
          Message(
            message: 'Hello, I am ${selectedModel.value.displayName}. How can I help you?',
            sentBy: selectedModel.value.modelId,
            createdAt: DateTime.now(),
            messageType: MessageType.text,
          ),
        ],
        currentUser: ChatUser(name: 'User', id: '1'),
        scrollController: ScrollController(),
        otherUsers: ImageGenerateModel.values
            .map((model) => ChatUser(
                  name: model.displayName,
                  id: model.modelId,
                  defaultAvatarImage: model.avatarUrl,
                  imageType: ImageType.network,
                ))
            .toList());
    super.onInit();
  }

  Future<Uint8List?> generateImage(String prompt) async {
    final result = await _huggingfaceRepository.generateImage(prompt, ImageGenerateModel.stableDiffusion);
    if (result == null) {
      showSnackBar(title: 'Generate image failed', type: SnackBarType.error);
      return null;
    }
    return result;
  }

  void onTapSend(String message, ReplyMessage replyMessage, MessageType messageType) async {
    chatController.addMessage(
      Message(
        message: message,
        sentBy: chatController.currentUser.id,
        createdAt: DateTime.now(),
        messageType: messageType,
        replyMessage: replyMessage,
      ),
    );
    chatController.addMessage(Message(
      id: 'thinking-message',
      message: 'Thinking...',
      sentBy: selectedModel.value.modelId,
      createdAt: DateTime.now(),
      messageType: MessageType.text,
      status: MessageStatus.pending,
    ));
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
      chatController.initialMessageList.removeWhere(
        (element) => element.id == 'thinking-message' && element.sentBy == selectedModel.value.modelId,
      );
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
