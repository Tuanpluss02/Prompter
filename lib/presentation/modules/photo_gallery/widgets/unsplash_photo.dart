import 'package:base/presentation/widgets/global/app_image.dart';
import 'package:flutter/material.dart';

class UnsplashPhoto extends StatelessWidget {
  const UnsplashPhoto(this.url, {super.key, this.fit = BoxFit.cover});
  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppImage(
          image: NetworkImage(url),
          fit: fit,
          progress: true,
          scale: 1,
        ),
      ],
    );
  }
}
