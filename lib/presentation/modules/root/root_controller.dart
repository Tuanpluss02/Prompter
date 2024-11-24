import 'dart:async';

import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/auth_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/modules/account/account_screen.dart';
import 'package:base/presentation/modules/home/home_screen.dart';
import 'package:base/presentation/modules/photo_gallery/photo_gallery_screen.dart';
import 'package:base/presentation/modules/search/search_screen.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootController extends BaseController {
  StreamSubscription? _authStateChangesSubscription;
  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

  var currentIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const PhotoGalleryScreen(),
    const AccountScreen(),
  ];

  Future<void> getCurrentUserData() async {
    if (!appProvider.isSignedIn) {
      return;
    }
    UserEntity? userEntity = await _userService.getUserById(appProvider.currentUserId);
    if (userEntity != null) {
      appProvider.updateUserData(userEntity);
    }
  }

  @override
  void onClose() {
    _authStateChangesSubscription?.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    _initAuthListener();
    getCurrentUserData();
  }

  onNavItemTaped(int index) {
    if (index == 2) {
      Get.toNamed(AppRoutes.aiChat);
      return;
    }
    currentIndex.value = index;
  }

  void _initAuthListener() {
    _authStateChangesSubscription = _authService.user.listen((User? user) {
      if (user == null) {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
