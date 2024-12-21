import 'package:base/app_provider.dart';
import 'package:base/common/localization/locale_manager.dart';
import 'package:base/domain/data/local/app_storage.dart';
import 'package:base/domain/services/auth_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    // local data key - value
    await Get.putAsync(() => AppStorage().sharedPreferences());

    Get.put(AuthService());

    Get.put(UserService());

    // global state and runtime data management
    Get.put(AppProvider());

    // localization
    Get.put(LanguageManager());
  }
}
