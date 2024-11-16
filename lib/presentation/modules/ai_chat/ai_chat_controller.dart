import 'package:base/app/utils/generate_id.dart';
import 'package:base/app/utils/snackbar.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/data/repositories/gemini_repository.dart';
import 'package:base/data/repositories/huggingface_repository.dart';
import 'package:base/services/chat_service.dart';
import 'package:base/services/cloudinary_service.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ChatMode { text, image }

class AiChatController extends BaseController {
  final HuggingfaceRepository _huggingfaceRepository = Get.find<HuggingfaceRepository>();
  final GeminiRepository _geminiRepository = Get.find<GeminiRepository>();
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final ChatService _chatService = Get.find<ChatService>();

  late final ChatController chatController;
  var chatViewState = ChatViewState.hasMessages.obs;
  var selectedModel = ImageGenerateModel.flux.obs;
  var chatMode = ChatMode.image.obs;

  @override
  void onInit() async {
    await initChatData(appProvider.currentUser.value.id ?? 'User');
    super.onInit();
  }

  initChatData(String userId) async {
    final List<Message> initialMessageList = await _chatService.getMessages(userId);
    if (initialMessageList.isEmpty) {
      initialMessageList.add(Message(
        message: 'Hello, I am ${selectedModel.value.displayName}. How can I help you?',
        sentBy: selectedModel.value.modelId,
        createdAt: DateTime.now(),
        messageType: MessageType.text,
      ));
    }
    chatController = ChatController(
        initialMessageList: initialMessageList,
        currentUser: ChatUser(
            name: appProvider.currentUser.value.username ?? 'User',
            id: appProvider.currentUser.value.id ?? 'User',
            imageType: ImageType.network,
            profilePhoto: appProvider.currentUser.value.profileImage ?? '',
            defaultAvatarImage: 'https://danviet.mediacdn.vn/296231569849192448/2024/6/13/son-tung-mtp-17182382517241228747767.jpg'),
        scrollController: ScrollController(),
        otherUsers: [
          ...ImageGenerateModel.values.map((model) => ChatUser(
                name: model.displayName,
                id: model.modelId,
                defaultAvatarImage: model.avatarUrl,
                profilePhoto: model.avatarUrl,
                imageType: ImageType.network,
              )),
          ChatUser(id: 'Gemini', name: 'Gemini')
        ]);
  }

  Future<Uint8List?> generateImage(String prompt) async {
    final result = await _huggingfaceRepository.generateImage(prompt, selectedModel.value);
    if (result == null) {
      showSnackBar(title: 'Generate image failed', type: SnackBarType.error);
      return null;
    }
    return result;
  }

  void onReactionTap(Message message, String reaction) {
    chatController.setReaction(emoji: reaction, messageId: message.id, userId: chatController.currentUser.id);
  }

  void onTapSend(String message, ReplyMessage replyMessage, MessageType messageType) async {
    final userMessage = Message(
      id: generateUniqueId(),
      message: message,
      sentBy: chatController.currentUser.id,
      createdAt: DateTime.now(),
      messageType: messageType,
      replyMessage: replyMessage,
    );
    final thinkingMessage = Message(
      id: 'thinking-message',
      message: 'Thinking...',
      sentBy: selectedModel.value.modelId,
      createdAt: DateTime.now(),
      messageType: MessageType.text,
      status: MessageStatus.pending,
    );
    addMessage(userMessage);
    chatController.addMessage(thinkingMessage);
    if (chatMode.value == ChatMode.image) {
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
      final imageMessage = Message(
        id: generateUniqueId(),
        message: response,
        sentBy: selectedModel.value.modelId,
        createdAt: DateTime.now(),
        messageType: MessageType.image,
      );
      addMessage(imageMessage);
    } else {
      _geminiRepository.chatGemini(message).then((response) {
        chatController.initialMessageList.removeWhere(
          (element) => element.id == 'thinking-message' && element.sentBy == 'Gemini',
        );
        final responseMessage = Message(
          id: generateUniqueId(),
          message: response ?? 'Sorry, I cannot understand your question',
          sentBy: 'Gemini',
          createdAt: DateTime.now(),
          messageType: MessageType.text,
        );
        addMessage(responseMessage);
      });
    }
  }

  void addMessage(Message message) {
    chatController.addMessage(message);
    _chatService.saveMessage(message, appProvider.currentUser.value.id ?? 'User');
  }
}
