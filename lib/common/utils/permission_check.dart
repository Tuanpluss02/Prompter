import 'package:base/presentation/shared/app_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkAndRequestPermission({required Permission permission}) async {
  PermissionStatus status = await permission.status;

  switch (status) {
    case PermissionStatus.granted:
      return true;
    case PermissionStatus.denied:
      bool isGranted = await _showRequestPermissionDialog();
      if (isGranted) {
        PermissionStatus newStatus = await Permission.storage.request();
        return newStatus.isGranted;
      }
      break;
    case PermissionStatus.permanentlyDenied:
      bool isGranted = await _showOpenSettingDialog();
      if (isGranted) {
        openAppSettings();
      }
      break;
    default:
      break;
  }
  return false;
}

Future<bool> _showRequestPermissionDialog() async {
  return Get.dialog<bool>(AppDialog(
    title: "Permission Required",
    content: "This app needs storage permission to save images.",
    primaryButtonText: "Allow",
    secondaryButtonText: "Deny",
    onPrimaryButtonTap: () => Get.back(result: true),
    onSecondaryButtonTap: () => Get.back(result: false),
  )).then((value) => value ?? false);
}

Future<bool> _showOpenSettingDialog() async {
  return Get.dialog<bool>(AppDialog(
    title: "Permission Required",
    content: "This app needs storage permission to save images. You can grant the permission from the app settings.",
    primaryButtonText: "Allow",
    secondaryButtonText: "Deny",
    onPrimaryButtonTap: () => Get.back(result: true),
    onSecondaryButtonTap: () => Get.back(result: false),
  )).then((value) => value ?? false);
}
