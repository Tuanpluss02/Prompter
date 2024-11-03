import 'package:base/app_provider.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  final _appProvider = Get.find<AppProvider>();
  final _excludedRoutes = [AppRoutes.forgotPassword, AppRoutes.register, AppRoutes.login, AppRoutes.welcome];

  @override
  RouteSettings? redirect(String? route) {
    if (!_appProvider.authenticated && !_excludedRoutes.contains(route)) {
      return RouteSettings(name: AppRoutes.login);
    }
    return null;
  }
}
