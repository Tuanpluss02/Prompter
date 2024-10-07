import 'package:base/app_provider.dart';
import 'package:base/app/posthog/posthog_manager.dart';

import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final AppProvider appProvider = Get.find<AppProvider>();
  final PosthogManager posthogManager = Get.find<PosthogManager>();

  final loading = false.obs;

  void logEvent({required String eventName, Map<String, Object>? properties}) {
    posthogManager.logEvent(eventName: eventName, properties: properties);
  }

  void onBackpress() {
    Get.back();
  }
}
