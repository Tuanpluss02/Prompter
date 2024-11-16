import 'package:base/data/entities/user.dart';
import 'package:base/services/auth_service.dart';
import 'package:base/services/user_service.dart';
import 'package:get/get.dart';

class AppProvider {
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() => _instance;

  AppProvider._internal();

  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

  var currentUser = const User().obs;

  bool get isSignedIn => _authService.currentUser != null;

  getUserInfomation() async {
    if (isSignedIn) {
      currentUser.value = await _userService.getUserInfo(_authService.currentUser!.uid);
    }
  }
}
