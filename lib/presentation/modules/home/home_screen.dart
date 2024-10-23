import 'package:base/base/base_screen.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity,
      height: 200,
    );
  }
}
