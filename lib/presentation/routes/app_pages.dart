import 'package:base/presentation/modules/authentication/login/login_binding.dart';
import 'package:base/presentation/modules/authentication/login/login_screen.dart';
import 'package:base/presentation/modules/authentication/register/register_binding.dart';
import 'package:base/presentation/modules/authentication/register/register_screen.dart';
import 'package:base/presentation/modules/root/root_binding.dart';
import 'package:base/presentation/modules/root/root_screen.dart';
import 'package:get/get.dart';
import 'package:base/presentation/modules/authentication/forgot_password/forgot_password_binding.dart';
import 'package:base/presentation/modules/authentication/forgot_password/forgot_password_screen.dart';
import 'package:base/presentation/modules/authentication/reset_password/reset_password_binding.dart';
import 'package:base/presentation/modules/authentication/reset_password/reset_password_screen.dart';

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
    GetPage(
      name: AppRoutes.forgot,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.reset,
      page: () => ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
