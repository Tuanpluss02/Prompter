import 'package:base/domain/services/post_service.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostService());
    Get.lazyPut(() => HomeController());
  }
}
