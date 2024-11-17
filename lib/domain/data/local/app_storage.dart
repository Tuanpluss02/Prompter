import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage extends GetxService {
  static final AppStorage _appStorage = AppStorage._init();

  factory AppStorage() {
    return _appStorage;
  }
  AppStorage._init();

  /// Returns an instance of SharedPreferences.
  Future<SharedPreferences> sharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  /// Sets a string value in SharedPreferences.
  static setString(String key, String value) {
    SharedPreferences pref = Get.find();
    pref.setString(key, value);
  }

  /// Gets a string value from SharedPreferences.
  static String? getString(String key) {
    SharedPreferences pref = Get.find();
    return pref.getString(key);
  }

  /// Sets an integer value in SharedPreferences.
  static setInt(String key, int value) {
    SharedPreferences pref = Get.find();
    pref.setInt(key, value);
  }

  /// Gets an integer value from SharedPreferences.
  static int? getInt(String key) {
    SharedPreferences pref = Get.find();
    return pref.getInt(key);
  }

  /// Sets a list of strings in SharedPreferences.
  static setListString(String key, List<String> value) {
    SharedPreferences pref = Get.find();
    pref.setStringList(key, value);
  }

  /// Gets a list of strings from SharedPreferences.
  static List<String>? getListString(String key) {
    SharedPreferences pref = Get.find();
    return pref.getStringList(key);
  }

  /// Sets a boolean value in SharedPreferences.
  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences pref = Get.find();
    return pref.setBool(key, value);
  }

  /// Gets a boolean value from SharedPreferences.
  static bool? getBool(String key) {
    SharedPreferences pref = Get.find();
    return pref.getBool(key);
  }

  /// Removes a value from SharedPreferences.
  static removeSharedPrefrences(String key) {
    SharedPreferences pref = Get.find();
    pref.remove(key);
  }
}

/// Contains keys used for storing data in SharedPreferences.
class SharedPreferencesKeys {
  static const sessionId = 'sessionId';
  static const accessToken = 'accessToken';
  static const refreshToken = 'refreshToken';
  static const darkMode = 'darkMode';
  static const localeCode = 'localeCode';
  static const hasSeenWelcome = 'hasSeenWelcome';
  static const lastTimeSendForgotOTP = 'lastTimeSendForgotOTP';
  static const lastTimeSendRegisterOTP = 'lastTimeSendRegisterOTP';
  static const isAuthBiometrics = 'isAuthBiometrics';
  static const tokenEContact = 'tokenEContact';
  static const deviceId = 'deviceId';
  static const secretKey = 'secretKey';
}
