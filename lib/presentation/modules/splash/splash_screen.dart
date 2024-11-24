import 'package:base/common/constants/app_strings.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'splash_controller.dart';

class SplashScreen extends BaseScreen<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    Widget title = Text(
      AppStrings.appName.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Larsseit',
        fontSize: 40,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
      ),
    );

    title = title
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
        .animate() // this wraps the previous Animate in another Animate
        .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
        .slide();
    return Scaffold(
      body: Center(
        child: title,
      ),
    );
  }
}
