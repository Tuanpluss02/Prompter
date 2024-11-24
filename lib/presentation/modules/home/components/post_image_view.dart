import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_image.dart';
import 'package:base/presentation/shared/utils/full_screen_image_view.dart';
import 'package:flutter/material.dart';

class PostImageView extends StatelessWidget {
  final ImageProvider<Object> image;
  final String? imageUrl;
  final ({bool showRemoveButton, Function() onTapRemove})? removeElevation;
  const PostImageView({super.key, this.removeElevation, required this.image, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FullScreenImageView(
          disposeLevel: DisposeLevel.low,
          imageUrl: imageUrl ?? '',
          child: Hero(
            tag: image.hashCode + DateTime.now().millisecondsSinceEpoch,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppImage(image: image),
            ),
          ),
        ),
        Visibility(
          visible: removeElevation?.showRemoveButton ?? false,
          child: Positioned(
            top: 5,
            right: 5,
            child: ScaleButton(
              onTap: removeElevation?.onTapRemove ?? () {},
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
