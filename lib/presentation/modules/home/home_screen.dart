import 'package:base/app/constants/app_color.dart';
import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @override
  bool get wrapWithSafeArea => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      // height: 200,
      child: ElevatedButton(
        onPressed: controller.signOut,
        child: const Text('Sign Out'),
      ),
    );
  }
}
