import 'package:base/presentation/widgets/global/app_image.dart';
import 'package:flutter/material.dart';

class UnsplashPhoto extends StatelessWidget {
  const UnsplashPhoto(this.id, {super.key, this.fit = BoxFit.cover});
  final String id;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppImage(
          image: NetworkImage("https://sf-flow-web-cdn.ciciai.com/obj/ocean-flow-web-sg/samantha/image-example/japanese-anime/japanese-anime-eg18.png"),
          fit: fit,
          progress: true,
          scale: 1,
        ),
      ],
    );
  }
}
