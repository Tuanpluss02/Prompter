import 'package:base/data/repositories/gemini_repository.dart';
import 'package:base/data/repositories/huggingface_repository.dart';
import 'package:base/services/cloudinary_service.dart';
import 'package:get/get.dart';

import 'ai_chat_controller.dart';

class AiChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CloudinaryService());
    Get.lazyPut(() => HuggingfaceRepository());
    Get.lazyPut(() => GeminiRepository());
    Get.lazyPut(() => AiChatController());
  }
}
