import 'package:base/app/utils/log.dart';
import 'package:base/base/base_controller.dart';
import 'package:base/presentation/modules/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends BaseController {
  // StreamSubscription? _authStateChangesSubscription;
  // final AuthService _authService = Get.find<AuthService>();

  // @override
  // void onInit() {
  //   super.onInit();
  //   _authStateChangesSubscription = _authService.user.listen((User? user) {
  //     if (user == null) {
  //       Get.offAllNamed(AppRoutes.login);
  //     }
  //   });
  // }

  // @override
  // void onClose() {
  //   _authStateChangesSubscription?.cancel();
  //   super.onClose();
  // }

  var currentIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];

  onNavItemTaped(int index) {
    Log.console('onNavItemTaped $index');
    if (index == 2) {
      return;
    }
    currentIndex.value = index;
  }
}
