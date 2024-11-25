import 'package:base/presentation/shared/global/app_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkAndRequestPermission({required Permission permission}) async {
  // final PermissionStatus status = await permission.status;

  final PermissionStatus tmpStatus = await permission.request();
  switch (tmpStatus) {
    case PermissionStatus.granted:
      // Have permission
      return true;
    case PermissionStatus.denied:
    case PermissionStatus.restricted:
      // Permission is restricted by the operating system and cannot be changed through normal settings
      _showRequestPermissionDialog(permission.name);
      return false;
    case PermissionStatus.permanentlyDenied:
      // Permission is blocked and "Don't ask again" is selected, need to go to settings to enable it again
      _showOpenSettingDialog(permission.name);
      return false;
    default:
      return false;
  }
}

Future<void> _showOpenSettingDialog(String permissionName) async {
  Get.dialog(AppDialog(
    title: "Permission Required",
    content: "This app needs $permissionName permission to continue. You can grant the permission from the app settings.",
    primaryButtonText: "Allow",
    secondaryButtonText: "Deny",
    onPrimaryButtonTap: () {
      openAppSettings();
      Get.back();
    },
    onSecondaryButtonTap: () => Get.back(),
  ));
}

Future<void> _showRequestPermissionDialog(String permissionName) async {
  Get.dialog(AppDialog(
    title: "Permission Required",
    content: "You need to grant $permissionName permission to continue.",
    primaryButtonText: "Allow",
    secondaryButtonText: "Deny",
    onPrimaryButtonTap: () => Get.back(result: true),
    onSecondaryButtonTap: () => Get.back(result: false),
  ));
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
