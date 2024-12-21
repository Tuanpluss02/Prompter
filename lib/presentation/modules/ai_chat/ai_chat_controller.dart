import 'package:base/common/constants/app_enums.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/utils/generate_id.dart';
import 'package:base/common/utils/image_utils.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/repositories/gemini_repository.dart';
import 'package:base/domain/repositories/huggingface_repository.dart';
import 'package:base/domain/services/chat_service.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/modules/ai_chat/ai_chat_binding.dart';
import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AiChatController extends BaseController {
  final AiChatPageData? pageData;
  final HuggingfaceRepository _huggingfaceRepository = Get.find<HuggingfaceRepository>();
  final GeminiRepository _geminiRepository = Get.find<GeminiRepository>();
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final ChatService _chatService = Get.find<ChatService>();
  late ChatController chatController = ChatController(
      textMessageController: textMessageController,
      initialMessageList: [],
      currentUser: ChatUser(
          name: appProvider.user.value.username ?? 'User',
          id: appProvider.user.value.id ?? 'User',
          imageType: ImageType.network,
          profilePhoto: appProvider.user.value.profileImage,
          defaultAvatarImage: AppStrings.defaultNetworkAvatar),
      otherUsers: [],
      scrollController: ScrollController());

  var chatViewState = ChatViewState.loading.obs;
  var selectedModel = GenerativeAiModel.gemini.obs;

  final TextEditingController textMessageController = TextEditingController();
  AiChatController({this.pageData});

  void addMessage(Message message) {
    chatController.addMessage(message);
    _chatService.saveMessage(message, appProvider.user.value.id ?? 'User');
  }

  Future<Uint8List?> generateImage(String prompt) async {
    final result = await _huggingfaceRepository.generateImage(prompt, selectedModel.value);
    if (result == null) {
      showSnackBar(title: 'Generate image failed', type: SnackBarType.error);
      return null;
    }
    return result;
  }

  initChatData(String userId) async {
    final List<Message> initialMessageList = await _chatService.getMessages(userId);
    if (initialMessageList.isEmpty) {
      final welcomeMessage = Message(
        id: generateUniqueId(),
        message: 'Hello, I am ${selectedModel.value.displayName}. How can I help you?',
        sentBy: selectedModel.value.modelId,
        createdAt: DateTime.now(),
        messageType: MessageType.text,
      );
      initialMessageList.add(welcomeMessage);
      _chatService.saveMessage(welcomeMessage, appProvider.user.value.id ?? 'User');
    }

    chatController = ChatController(
      textMessageController: textMessageController,
      initialMessageList: initialMessageList,
      currentUser: ChatUser(
          name: appProvider.user.value.username ?? 'User',
          id: appProvider.user.value.id ?? 'User',
          imageType: ImageType.network,
          profilePhoto: appProvider.user.value.profileImage,
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

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initChatData(appProvider.user.value.id ?? 'User');
    });
  }

  onLongPressMessage(Message message) {
    if (message.messageType == MessageType.text) {
      Clipboard.setData(ClipboardData(text: message.message));
      Fluttertoast.showToast(
        msg: "Copied to clipboard",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      ImageUtils.saveImageToGallery(imageUrl: message.message);
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (pageData != null) {
      textMessageController.text = pageData?.prompt ?? '';
    }
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
    addMessage(userMessage);
    if (selectedModel.value.modelType == ModelType.textToImage) {
      Uint8List? img = await generateImage(message);
      if (img == null) {
        showSnackBar(title: 'Generate image failed', type: SnackBarType.error);
        chatController.setTypingIndicator = false;
        return;
      }
      final response = await _cloudinaryService.uploadImage(img);
      if (response == null) {
        showSnackBar(title: 'Upload image failed', type: SnackBarType.error);
        chatController.setTypingIndicator = false;
        return;
      }

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
      final previousGeminiMessages = chatController.initialMessageList.where((element) => element.sentBy == selectedModel.value.modelId).map((e) => e.message).toList();
      final geminiResponse = await _geminiRepository.chatGemini(message, previousGeminiMessages);
      if (geminiResponse == null) {
        showSnackBar(title: 'Something went wrong, please try again', type: SnackBarType.error);
        chatController.setTypingIndicator = false;
        return;
      }
      final responseMessage = Message(
        id: generateUniqueId(),
        message: geminiResponse,
        sentBy: selectedModel.value.modelId,
        createdAt: DateTime.now(),
        messageType: MessageType.text,
      );
      chatController.setTypingIndicator = false;
      addMessage(responseMessage);
    }
  }
}
