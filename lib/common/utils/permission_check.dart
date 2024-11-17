import 'package:base/presentation/shared/global/app_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkAndRequestPermission({required Permission permission}) async {
  PermissionStatus status = await permission.status;

  switch (status) {
    case PermissionStatus.granted:
      return true;
    case PermissionStatus.denied:
      bool isGranted = await _showRequestPermissionDialog(permission.name);
      if (isGranted) {
        PermissionStatus newStatus = await Permission.storage.request();
        return newStatus.isGranted;
      }
      break;
    case PermissionStatus.permanentlyDenied:
      bool isGranted = await _showOpenSettingDialog(permission.name);
      if (isGranted) {
        openAppSettings();
      }
      break;
    default:
      break;
  }
  return false;
}

Future<bool> _showRequestPermissionDialog(String permissionName) async {
  return Get.dialog<bool>(AppDialog(
    title: "Permission Required",
    content: "You need to grant $permissionName permission to continue.",
    primaryButtonText: "Allow",
    secondaryButtonText: "Deny",
    onPrimaryButtonTap: () => Get.back(result: true),
    onSecondaryButtonTap: () => Get.back(result: false),
  )).then((value) => value ?? false);
}

Future<bool> _showOpenSettingDialog(String permissionName) async {
  return Get.dialog<bool>(AppDialog(
    title: "Permission Required",
    content: "This app needs $permissionName permission to continue. You can grant the permission from the app settings.",
    primaryButtonText: "Allow",
    secondaryButtonText: "Deny",
    onPrimaryButtonTap: () => Get.back(result: true),
    onSecondaryButtonTap: () => Get.back(result: false),
  )).then((value) => value ?? false);
}

extension GetPermissionName on Permission {
  String get name {
    return switch (this) {
      Permission.camera => "Camera",
      Permission.storage => "Storage",
      Permission.photos => "Photos",
      Permission.mediaLibrary => "Media Library",
      Permission.microphone => "Microphone",
      Permission.speech => "Speech",
      Permission.location => "Location",
      Permission.notification => "Notification",
      Permission.bluetooth => "Bluetooth",
      Permission.contacts => "Contacts",
      _ => ""
    };
  }
}
