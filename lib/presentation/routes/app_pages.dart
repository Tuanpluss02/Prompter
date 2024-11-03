import 'package:base/presentation/modules/authentication/login/login_binding.dart';
import 'package:base/presentation/modules/authentication/login/login_screen.dart';
import 'package:base/presentation/modules/authentication/register/register_binding.dart';
import 'package:base/presentation/modules/authentication/register/register_screen.dart';
import 'package:base/presentation/modules/root/root_binding.dart';
import 'package:base/presentation/modules/root/root_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static String initial = AppRoutes.login;

  static final appRoutes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.root,
      page: () => RootScreen(),
      binding: RootBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
      binding: RegisterBinding(),
    ),
  ];
}
