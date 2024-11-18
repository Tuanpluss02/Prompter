import 'package:base/presentation/shared/global/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaView extends StatelessWidget {
  const MediaView({super.key, this.images, this.maxHeight});

  final List<String>? images;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? Get.width * 0.6,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images!.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppImage(image: NetworkImage(images![index])),
            ),
          );
        },
      ),
    );
  }
}
