import 'package:base/common/constants/app_color.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/photo_gallery/components/photo_gallery_grid.dart';
import 'package:base/presentation/shared/animated/animated_rotation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'photo_gallery_controller.dart';

class PhotoGalleryScreen extends BaseScreen<PhotoGalleryController> {
  const PhotoGalleryScreen({super.key});

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => FloatingActionButtonLocation.endDocked;

  void onFloatingActionButtonPressed() async {
    controller.isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    controller.isLoading.value = false;
  }

  @override
  Widget? buildFloatingActionButton() {
    return GestureDetector(
      onTap: () {
        onFloatingActionButtonPressed();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
        child: Obx(() => AnimatedCustomRotation(
              curve: Curves.fastEaseInToSlowEaseOut,
              duration: Duration(milliseconds: 700),
              isRotating: controller.isLoading.value,
              child: const Icon(Icons.refresh, color: Colors.white),
            )),
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() => Visibility(
        visible: controller.aiImages.length >= 25,
        replacement: const Center(
          child: Text('No images found'),
        ),
        child: PhotoGalleryGrid(
          aiImages: controller.aiImages,
        )));
  }
}
