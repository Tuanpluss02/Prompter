import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/auth_service.dart';
import 'package:get/get.dart';

class AppProvider {
  static final AppProvider _instance = AppProvider._internal();
  final AuthService _authService = Get.find<AuthService>();

  var user = const UserEntity().obs;
  factory AppProvider() => _instance;
  AppProvider._internal();

  String get currentUserId => _authService.currentUser?.uid ?? '';

  bool get isSignedIn => _authService.currentUser != null;

  clearUserData() {
    user.value = const UserEntity();
  }

  updateUserData(UserEntity userEntity) {
    user.value = userEntity;
  }
}
