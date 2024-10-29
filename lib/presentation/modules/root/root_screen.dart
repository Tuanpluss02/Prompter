import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

import 'root_controller.dart';

class RootScreen extends BaseScreen<RootController> {
  const RootScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() => IndexedStack(
          index: controller.currentIndex.value > 2 ? controller.currentIndex.value - 1 : controller.currentIndex.value,
          children: controller.screens,
        ));
  }

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return Obx(() => FBottomNavigationBar(
          index: controller.currentIndex.value,
          onChange: controller.onNavItemTaped,
          children: [
            FBottomNavigationBarItem(
              icon: FIcon(FAssets.icons.house),
              label: SizedBox.shrink(),
            ),
            FBottomNavigationBarItem(
              icon: FIcon(FAssets.icons.search),
              label: SizedBox.shrink(),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(16),
              ),
              child: FIcon(FAssets.icons.plus),
            ),
            FBottomNavigationBarItem(
              icon: FIcon(FAssets.icons.layoutGrid),
              label: SizedBox.shrink(),
            ),
            FBottomNavigationBarItem(
              icon: FIcon(FAssets.icons.user),
              label: SizedBox.shrink(),
            ),
          ],
        ));
  }
}
