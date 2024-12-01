import 'package:base/common/constants/app_color.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/photo_gallery/components/photo_gallery_grid.dart';
import 'package:base/presentation/shared/animated/animated_rotation.dart';
import 'package:base/presentation/shared/global/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'photo_gallery_controller.dart';

class PhotoGalleryScreen extends BaseScreen<PhotoGalleryController> {
  const PhotoGalleryScreen({super.key});

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation => FloatingActionButtonLocation.endDocked;

  @override
  Widget? buildFloatingActionButton() {
    return GestureDetector(
      onTap: () => controller.refreshData(),
      child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
          child: CustomAnimatedRotation(
            controller: controller.refreshController,
            curve: Curves.fastEaseInToSlowEaseOut,
            duration: Duration(milliseconds: 700),
            child: const Icon(Icons.refresh, color: Colors.white),
          )),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() => Visibility(
        visible: controller.aiImages.length >= 25,
        replacement: const Center(
          child: AppLoadingIndicator(),
        ),
        child: PhotoGalleryGrid(
          aiImages: controller.aiImages,
        )));
  }
}
