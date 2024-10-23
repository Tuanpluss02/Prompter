import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'root_controller.dart';

class RootScreen extends BaseScreen<RootController> {
  const RootScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() => IndexedStack(
          index: controller.currentIndex.value,
          children: controller.screens,
        ));
  }
}
