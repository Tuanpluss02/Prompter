import 'package:get/get.dart';

import 'profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    var args = Get.arguments;
    if (args is ProfilePageData) {
      Get.lazyPut(() => ProfileController(pageData: args));
    } else {
      throw Exception('Invalid arguments');
    }
  }
}

class ProfilePageData {
  final String userId;

  const ProfilePageData({required this.userId});
}
