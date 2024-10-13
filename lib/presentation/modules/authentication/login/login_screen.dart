import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';

class LoginScreen extends BaseScreen<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: controller.signInGoogle,
                child: const Text('Sign in with Google')),
            ElevatedButton(
                onPressed: () => controller.registerWithEmailAndPassword(
                    'tuan@test.com', '123456'),
                child: const Text('Register')),
            ElevatedButton(
                onPressed: () => controller.signInWithEmailAndPassword(
                    'tuan@test.com', '123456'),
                child: const Text('Sign in')),
          ],
        ),
      ),
    );
  }
}
