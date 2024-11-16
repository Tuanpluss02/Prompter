import 'package:base/app/app_links/app_links_handler.dart';
import 'package:base/app/localization/locale_manager.dart';
import 'package:base/app_provider.dart';
import 'package:base/data/local/app_storage.dart';
import 'package:base/services/auth_service.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    // local data key - value
    await Get.putAsync(() => AppStorage().sharedPreferences());

    Get.put(AuthService());

    // app links handling
    Get.put(AppLinksHandler());

    // global state and runtime data management
    Get.put(AppProvider());

    // localization
    Get.put(LanguageManager());
  }
}
