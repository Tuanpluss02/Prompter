import 'package:base/presentation/dialog/dialog_loading.dart';

import '../../app/constants/app_nums.dart';

class ApiWidget {
  static Future<dynamic> checkTimeCallApi(dynamic api, {bool isDimiss = true}) async {
    DialogLoading.showLoading();
    Stopwatch stopwatch = Stopwatch()..start();
    final result = await api;
    stopwatch.stop();
    if (stopwatch.elapsedMilliseconds < 200) {
      await Future.delayed(AppNums.firstStepDuration);
    }
    if (isDimiss) DialogLoading.dismissLoading();
    return result;
  }
}
