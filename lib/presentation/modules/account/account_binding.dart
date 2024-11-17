import 'package:get/get.dart';

import 'account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    var userId = Get.parameters['userId'];
    Get.lazyPut(() => AccountController(userId: userId));
  }
}
