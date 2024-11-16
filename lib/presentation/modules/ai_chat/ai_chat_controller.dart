import 'package:base/app/constants/app_enums.dart';
import 'package:base/app/constants/app_strings.dart';
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

class AiChatController extends BaseController {
  final HuggingfaceRepository _huggingfaceRepository = Get.find<HuggingfaceRepository>();
  final GeminiRepository _geminiRepository = Get.find<GeminiRepository>();
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final ChatService _chatService = Get.find<ChatService>();
  late ChatController chatController = ChatController(
      initialMessageList: [],
      currentUser: ChatUser(
          name: appProvider.currentUser.value.username ?? 'User',
          id: appProvider.currentUser.value.id ?? 'User',
          imageType: ImageType.network,
          profilePhoto: appProvider.currentUser.value.profileImage ?? '',
          defaultAvatarImage: AppStrings.defaultNetworkAvatar),
      otherUsers: [],
      scrollController: ScrollController());
  var chatViewState = ChatViewState.loading.obs;
  var selectedModel = GenerativeAiModel.gemini.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initChatData(appProvider.currentUser.value.id ?? 'User');
    });
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
          defaultAvatarImage: AppStrings.defaultNetworkAvatar),
      scrollController: ScrollController(),
      otherUsers: GenerativeAiModel.values
          .map((model) => ChatUser(
                name: model.displayName,
                id: model.modelId,
                defaultAvatarImage: model.avatarUrl,
                profilePhoto: model.avatarUrl,
                imageType: ImageType.network,
              ))
          .toList(),
    );
    chatViewState.value = ChatViewState.hasMessages;
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
    chatController.setTypingIndicator = true;
    // final thinkingMessage = Message(
    //   id: 'thinking-message',
    //   message: 'Thinking...',
    //   sentBy: selectedModel.value.modelId,
    //   createdAt: DateTime.now(),
    //   messageType: MessageType.text,
    //   status: MessageStatus.pending,
    // );
    addMessage(userMessage);
    // chatController.addMessage(thinkingMessage);
    if (selectedModel.value.modelType == ModelType.textToImage) {
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
      // chatController.initialMessageList.removeWhere(
      //   (element) => element.id == 'thinking-message' && element.sentBy == selectedModel.value.modelId,
      // );
      final imageMessage = Message(
        id: generateUniqueId(),
        message: response,
        sentBy: selectedModel.value.modelId,
        createdAt: DateTime.now(),
        messageType: MessageType.image,
      );
      chatController.setTypingIndicator = false;
      addMessage(imageMessage);
    } else {
      final geminiResponse = await _geminiRepository.chatGemini(message);
      // chatController.initialMessageList.removeWhere((element) => element.id == 'thinking-message' && element.sentBy == selectedModel.value.modelId);
      final responseMessage = Message(
        id: generateUniqueId(),
        message: geminiResponse ?? 'Sorry, I cannot understand your question',
        sentBy: selectedModel.value.modelId,
        createdAt: DateTime.now(),
        messageType: MessageType.text,
      );
      chatController.setTypingIndicator = false;
      addMessage(responseMessage);
    }
  }

  void addMessage(Message message) {
    chatController.addMessage(message);
    _chatService.saveMessage(message, appProvider.currentUser.value.id ?? 'User');
  }
}
