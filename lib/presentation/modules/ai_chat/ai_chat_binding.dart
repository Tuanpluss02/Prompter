import 'package:base/domain/repositories/gemini_repository.dart';
import 'package:base/domain/repositories/huggingface_repository.dart';
import 'package:base/domain/services/chat_service.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:get/get.dart';

import 'ai_chat_controller.dart';

class AiChatBinding extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    Get.lazyPut(() => ChatService());
    Get.lazyPut(() => CloudinaryService());
    Get.lazyPut(() => HuggingfaceRepository());
    Get.lazyPut(() => GeminiRepository());
    Get.lazyPut(() => AiChatController(pageData: args));
  }
}

class AiChatPageData {
  final String? prompt;

  AiChatPageData({this.prompt});
}
