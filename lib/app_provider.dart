import 'package:base/app/utils/log.dart';
import 'package:base/data/local/app_storage.dart';
import 'package:base/presentation/modules/home/components/list_banner_widget.dart';
import 'package:base/presentation/modules/home/components/list_news_widget.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';

import 'data/entities/user_entity.dart';

class AppProvider {
  Rx<User> user = const User().obs;

  RxList<BannerItem> investmentBanners = <BannerItem>[].obs;

  RxList<BannerItem> advertisingBanners = <BannerItem>[].obs;

  void updateUser(User newUser) {
    user.value = newUser;
  }

  Future<void> setAuthData({
    required String accessToken,
    required String refreshToken,
  }) async {
    AppStorage.setString(SharedPreferencesKeys.accessToken, accessToken);
    AppStorage.setString(SharedPreferencesKeys.refreshToken, refreshToken);
    await setDeviceId();
  }

  setDeviceId() async {
    String deviceId = await getDeviceId();
    AppStorage.setString(SharedPreferencesKeys.deviceId, deviceId);
  }

  void clearAuthData() {
    AppStorage.removeSharedPrefrences(SharedPreferencesKeys.accessToken);
    AppStorage.removeSharedPrefrences(SharedPreferencesKeys.refreshToken);
    AppStorage.removeSharedPrefrences(SharedPreferencesKeys.deviceId);
    AppStorage.removeSharedPrefrences(SharedPreferencesKeys.isAuthBiometrics);
    updateUser(const User());
  }

  bool get isAuthenticated =>
      AppStorage.getString(SharedPreferencesKeys.accessToken) != null &&
      AppStorage.getString(SharedPreferencesKeys.refreshToken) != null;

  /// trending news
  ///
  /// được gán lần đầu tại hàm [_initData].[_getTrendingNews] của [HomeController]
  final RxList<NewsItem> listTrendingNews = RxList([]);
}

extension GetDeviceId on AppProvider {
  Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = '';

    try {
      if (GetPlatform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (GetPlatform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
      }
    } catch (e) {
      Log.console(e.toString());
    }

    return deviceId;
  }
}
