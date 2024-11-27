import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/photo_gallery/components/photo_gallery_grid.dart';
import 'package:flutter/material.dart';

import 'photo_gallery_controller.dart';

class PhotoGalleryScreen extends BaseScreen<PhotoGalleryController> {
  const PhotoGalleryScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return StreamBuilder(
        stream: controller.aiImages.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PhotoGalleryGrid(
              aiImages: snapshot.data ?? [],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
