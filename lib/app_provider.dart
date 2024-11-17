import 'package:base/app/utils/log.dart';
import 'package:base/domain/data/entities/user.dart';
import 'package:base/domain/services/auth_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:get/get.dart';

class AppProvider {
  static final AppProvider _instance = AppProvider._internal();

  factory AppProvider() => _instance;

  AppProvider._internal();

  final AuthService _authService = Get.find<AuthService>();
  final UserService _userService = Get.find<UserService>();

  var user = const UserEntity().obs;

  bool get isSignedIn => _authService.currentUser != null;

  getUserInfomation({String? userId}) async {
    if (isSignedIn) {
      user.value = await _userService.getUserInfo(userId ?? _authService.currentUser!.uid);
      Log.console('Got user info: ${user.value.toJson()}');
    }
  }

  signOut() async {
    await _authService.signOut();
    user.value = const UserEntity();
  }
}
