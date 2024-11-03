import 'dart:async';

import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AppProvider extends GetxService {
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() => _instance;

  AppProvider._internal();

  bool authenticated = false;
  StreamSubscription? _authStateChangesSubscription;
  final AuthService _authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    _authStateChangesSubscription = _authService.user.listen((User? user) {
      if (user == null) {
        authenticated = false;
        Get.offAllNamed(AppRoutes.login);
      } else {
        authenticated = true;
      }
    });
  }

  @override
  void onClose() {
    _authStateChangesSubscription?.cancel();
    super.onClose();
  }
}
