import 'dart:convert';
import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/presentation/widgets/overlay_success_mission.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

class GetPathDirectory {
  static Future<String> prepareSaveDir() async {
    String localPath;
    localPath = (await getSavedDir())!;
    final savedDir = Directory(localPath);
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
    return localPath;
  }

  static Future<String?> getSavedDir() async {
    String? externalStorageDirPath;

    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (err) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath = (await getApplicationDocumentsDirectory()).path;
    }
    return externalStorageDirPath;
  }

  static Future<File> downloadFile(
      {required String image,
      required BuildContext context,
      required String title}) async {
    if (image == '') {
      showBadgeNotification(
          context: context,
          title: title,
          content: tr(LocaleKeys.download_fail),
          prefixWidget: SvgPicture.asset(SvgPath.icOverlayFail));
    }
    const Base64Codec base64 = Base64Codec();
    final bytes = base64.decode(image);
    String localPath = await prepareSaveDir();
    String dir = '$localPath/qr_${DateTime.now().millisecondsSinceEpoch}.png';
    File file = File(dir);
    if (!file.existsSync()) file.create();
    await file.writeAsBytes(bytes).then(
          (value) {},
        );
    if (context.mounted) {}
    return file;
  }
}
