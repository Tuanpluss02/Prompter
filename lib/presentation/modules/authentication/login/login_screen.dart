import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';

class LoginScreen extends BaseScreen<LoginController> {
  const LoginScreen({super.key});

  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
