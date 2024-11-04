import 'package:base/base/base_screen.dart';
import 'package:base/presentation/modules/photo_gallery/components/photo_gallery_grid.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'photo_gallery_controller.dart';

class PhotoGalleryScreen extends BaseScreen<PhotoGalleryController> {
  const PhotoGalleryScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() => controller.aiImages.isEmpty
        ? Center(child: AppLoadingIndicator())
        : PhotoGalleryGrid(
            aiImages: controller.aiImages,
          ));
  }
}
