import 'package:base/base/base_controller.dart';
import 'package:base/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();

  void signOut() {
    _authService.signOut();
  }
}
