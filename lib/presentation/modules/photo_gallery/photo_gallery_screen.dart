import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/photo_gallery/components/photo_gallery_grid.dart';
import 'package:base/presentation/modules/photo_gallery/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';

import 'photo_gallery_controller.dart';

class PhotoGalleryScreen extends BaseScreen<PhotoGalleryController> {
  const PhotoGalleryScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return FutureBuilder(
        future: controller.initData(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: AppLoadingIndicator());
          }
          return PhotoGalleryGrid(
            aiImages: data.data ?? [],
          );
        });
  }
}
