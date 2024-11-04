import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'photo_gallery_controller.dart';

class PhotoGalleryScreen extends BaseScreen<PhotoGalleryController> {
  const PhotoGalleryScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    // return PhotoGallery(
    //   collectionId: '12123123',
    // );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => controller.aiImages.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Image.network(
                  controller.aiImages.first.defaultImage?.url ?? '',
                  width: 200,
                  height: 200,
                ),
        ),
        ElevatedButton(
          onPressed: controller.onRefresh,
          child: const Text('Refresh'),
        ),
      ],
    );
  }
}
