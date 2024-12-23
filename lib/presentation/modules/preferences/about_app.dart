import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/presentation/modules/preferences/preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class AboutTheApp extends GetView<PreferencesController> {
  const AboutTheApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget title = Text(
      AppStrings.appName.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Larsseit',
        fontSize: 60,
        fontWeight: FontWeight.bold,
        letterSpacing: 5,
      ),
    );

    title = title
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 3000.ms, color: AppColors.primaryColor)
        .animate() // this wraps the previous Animate in another Animate
        .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text('About Prompter'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: Center(child: title),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Prompter is a Flutter application designed to provide a seamless and efficient user experience for managing and interacting with AI-generated content. The app leverages various AI models to generate images and text, and integrates with Firebase for authentication and data storage. The app is designed to be user-friendly and intuitive, with a clean and modern user interface. The app is built using the Flutter framework, which allows for cross-platform development and a consistent user experience across different devices. The app is designed to be scalable and extensible, with the ability to add new features and functionality in the future.',
                  style: TextStyle(
                    fontFamily: 'Larsseit',
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Text('Powered by StormX',
                  style: TextStyle(
                    fontFamily: 'Larsseit',
                    fontSize: 16,
                  )),
              Text('Version: 1.0.0',
                  style: TextStyle(
                    fontFamily: 'Larsseit',
                    fontSize: 16,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
