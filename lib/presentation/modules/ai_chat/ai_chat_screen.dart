import 'package:base/base/base_screen.dart';
import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ai_chat_controller.dart';

class AiChatScreen extends BaseScreen<AiChatController> {
  const AiChatScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() => ChatView(
          chatController: controller.chatController,
          chatViewState: controller.chatViewState.value,
        ));
  }
}
