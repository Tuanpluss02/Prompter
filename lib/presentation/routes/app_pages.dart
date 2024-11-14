import 'package:base/presentation/modules/ai_chat/ai_chat_binding.dart';
import 'package:base/presentation/modules/ai_chat/ai_chat_screen.dart';
import 'package:base/presentation/modules/authentication/forgot_password/forgot_password_binding.dart';
import 'package:base/presentation/modules/authentication/forgot_password/forgot_password_screen.dart';
import 'package:base/presentation/modules/authentication/login/login_binding.dart';
import 'package:base/presentation/modules/authentication/login/login_screen.dart';
import 'package:base/presentation/modules/authentication/register/register_binding.dart';
import 'package:base/presentation/modules/authentication/register/register_screen.dart';
import 'package:base/presentation/modules/authentication/reset_password/reset_password_binding.dart';
import 'package:base/presentation/modules/authentication/reset_password/reset_password_screen.dart';
import 'package:base/presentation/modules/root/root_binding.dart';
import 'package:base/presentation/modules/root/root_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static String initial = AppRoutes.root;

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
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
        name: AppRoutes.aiChat,
        page: () => AiChatScreen(),
        binding: AiChatBinding(),
        transition: Transition.fade),
  ];
}
