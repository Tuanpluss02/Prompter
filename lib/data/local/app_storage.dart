import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage extends GetxService {
  static final AppStorage _appStorage = AppStorage._init();

  factory AppStorage() {
    return _appStorage;
  }
  AppStorage._init();

  Future<SharedPreferences> sharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static setString(String key, String value) {
    SharedPreferences pref = Get.find();
    pref.setString(key, value);
  }

  static String? getString(String key) {
    SharedPreferences pref = Get.find();
    return pref.getString(key);
  }

  static setInt(String key, int value) {
    SharedPreferences pref = Get.find();
    pref.setInt(key, value);
  }

  static int? getInt(String key) {
    SharedPreferences pref = Get.find();
    return pref.getInt(key);
  }

  static setListString(String key, List<String> value) {
    SharedPreferences pref = Get.find();
    pref.setStringList(key, value);
  }

  static List<String>? getListString(String key) {
    SharedPreferences pref = Get.find();
    return pref.getStringList(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    SharedPreferences pref = Get.find();
    return pref.setBool(key, value);
  }

  static bool? getBool(String key) {
    SharedPreferences pref = Get.find();
    return pref.getBool(key);
  }

  static removeSharedPrefrences(String key) {
    SharedPreferences pref = Get.find();
    pref.remove(key);
  }
}

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
