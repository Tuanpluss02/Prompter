import 'package:base/domain/services/auth_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();

  void signOut() {
    _authService.signOut();
  }
}
