import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';
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
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: controller.currentIndex.value == 0 ? Colors.blue : Colors.grey),
              onPressed: () => controller.onNavItemTaped(0),
            ),
            IconButton(
              icon: Icon(Icons.chat_bubble_outline, color: controller.currentIndex.value == 1 ? Colors.blue : Colors.grey),
              onPressed: () => controller.onNavItemTaped(1),
            ),
            const SizedBox(width: 40), // The dummy child for the notch
            IconButton(
              icon: Icon(Icons.notifications_none, color: controller.currentIndex.value == 3 ? Colors.blue : Colors.grey),
              onPressed: () => controller.onNavItemTaped(3),
            ),
            IconButton(
              icon: Icon(Icons.person_outline, color: controller.currentIndex.value == 4 ? Colors.blue : Colors.grey),
              onPressed: () => controller.onNavItemTaped(4),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget? buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () => controller.onNavItemTaped(2),
      child: const Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
  }
}
