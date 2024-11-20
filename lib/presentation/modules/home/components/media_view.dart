import 'package:base/presentation/modules/home/components/post_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaView extends StatelessWidget {
  const MediaView({super.key, required this.images, this.maxHeight});

  final List<String> images;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? Get.width * 0.7,
      ),
      child: images.length.isEqual(1)
          ? PostImageView(
              image: NetworkImage(images.first),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return PostImageView(
                  image: NetworkImage(images[index]),
                );
              },
            ),
    );
  }
}
