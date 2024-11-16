import 'package:base/services/auth_service.dart';
import 'package:get/get.dart';

class AppProvider extends GetxService {
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() => _instance;

  AppProvider._internal();

  final AuthService _authService = Get.find<AuthService>();

  bool get isSignedIn => _authService.currentUser != null;
}
