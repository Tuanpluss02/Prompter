import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'ai_chat_controller.dart';

class AiChatScreen extends BaseScreen<AiChatController> {
  const AiChatScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => controller.generateImage(
                  'Ink wash painting with pointillism, the water town of the south of the Yangtze River, a river running through, with gardens on both sides, green hues spread on a large area, Chinese aesthetics, use of negative space, minimalism'),
              child: Text('Generate Image')),
          Obx(() => controller.image.value),
        ],
      ),
    );
  }
}
