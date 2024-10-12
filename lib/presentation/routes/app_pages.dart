import 'package:base/presentation/modules/authentication/login/login_binding.dart';
import 'package:base/presentation/modules/authentication/login/login_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static String initial = AppRoutes.welcome;

  static final appRoutes = [
    GetPage(
        name: AppRoutes.login,
        page: () => LoginScreen(),
        binding: LoginBinding()),
  ];
}
