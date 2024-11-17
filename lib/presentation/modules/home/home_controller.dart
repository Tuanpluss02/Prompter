import 'package:base/domain/services/auth_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  final AuthService _authService = Get.find<AuthService>();

  final RefreshController refreshController = RefreshController();

  void signOut() {
    _authService.signOut();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    refreshController.refreshCompleted();
  }
}
