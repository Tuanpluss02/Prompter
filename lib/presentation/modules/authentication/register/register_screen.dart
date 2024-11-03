import 'package:base/app/constants/app_color.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/widgets/app_back_button.dart';
import 'package:flutter/material.dart';

import 'register_controller.dart';

class RegisterScreen extends BaseScreen<RegisterController> {
  const RegisterScreen({super.key});
  @override
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: [
        AppBackButton(),
      ],
    );
  }
}
