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
          index: controller.currentIndex.value,
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
              label: const Text('Home'),
            ),
            FBottomNavigationBarItem(
              icon: FIcon(FAssets.icons.layoutGrid),
              label: const Text('Browse'),
            ),
            Container(
              width: 20,
              height: 20,
              color: Colors.amber,
            ),
            FBottomNavigationBarItem(
              icon: FIcon(FAssets.icons.libraryBig),
              label: const Text('Library'),
            ),
            FBottomNavigationBarItem(
              icon: FIcon(FAssets.icons.search),
              label: const Text('Search'),
            ),
          ],
        ));
  }
}
