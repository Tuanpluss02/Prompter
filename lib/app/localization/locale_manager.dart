import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/data/local/app_storage.dart';
import 'package:get/get.dart';

class LanguageOption {
  final Locale locale;
  final String displayName;

  LanguageOption({
    required this.locale,
    required this.displayName,
  });
}

class LanguageManager extends GetxController {
  List<LanguageOption> getLanguageOptions() {
    return [
      LanguageOption(
        locale: const Locale('en'),
        displayName: 'English',
      ),
      LanguageOption(
        locale: const Locale('vi'),
        displayName: 'Tiếng Việt',
      ),
    ];
  }

  Locale getSelectedLanguage() {
    String localeCode = AppStorage.getString(SharedPreferencesKeys.localeCode) ?? Get.deviceLocale!.languageCode;
    return Locale(localeCode);
  }

  Future<void> changeLanguage({
    required Locale locale,
  }) async {
    await Get.context!.setLocale(locale);
    Get.context!.setLocale(locale);
    Get.updateLocale(locale);
    AppStorage.setString(SharedPreferencesKeys.localeCode, locale.languageCode);
  }
}
