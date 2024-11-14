import 'package:base/data/repositories/huggingface_repository.dart';
import 'package:get/get.dart';

import 'ai_chat_controller.dart';

class AiChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HuggingfaceRepository());
    Get.lazyPut(() => AiChatController());
  }
}
