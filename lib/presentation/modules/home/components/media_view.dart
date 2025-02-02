import 'package:base/presentation/modules/home/components/post_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MediaView extends StatelessWidget {
  final List<String> images;

  final double? maxHeight;
  const MediaView({super.key, required this.images, this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight ?? Get.width * 0.7,
      ),
      child: images.length.isEqual(1)
          ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: PostImageView(
                imageUrl: images.first,
                image: NetworkImage(images.first),
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.only(right: 12, left: index == 0 ? 12 : 0),
                  child: PostImageView(
                    imageUrl: images[index],
                    image: NetworkImage(images[index]),
                  ),
                );
              },
            ),
    );
  }
}
