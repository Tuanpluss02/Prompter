import 'package:flutter/material.dart';
import 'package:base/app_provider.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final _appProvider = Get.find<AppProvider>();
  final _excludedRoutes = [
    AppRoutes.forgot,
    AppRoutes.register,
    AppRoutes.login,
    AppRoutes.splash,
    AppRoutes.welcome
  ];
  @override
  RouteSettings? redirect(String? route) {
    if (!_excludedRoutes.contains(route) && !_appProvider.isAuthenticated) {
      return const RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
