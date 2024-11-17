import 'package:base/common/utils/log.dart';
import 'package:base/domain/data/entities/user_entity.dart';
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
      final UserEntity? userData = await _userService.getUserInfo(userId ?? _authService.currentUser!.uid);
      if (userData == null) {
        Log.console('User not found');
        return;
      }
      user.value = userData;
      Log.console('Got user info: ${user.value.toJson()}');
    }
  }

  signOut() async {
    await _authService.signOut();
    user.value = const UserEntity();
  }
}
