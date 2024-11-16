import 'package:flutter/material.dart';
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
      openAppSettings();
      break;
    default:
      break;
  }
  return false;
}

Future<bool> _showRequestPermissionDialog() async {
  return Get.dialog<bool>(
    AppDialog(),
  ).then((value) => value ?? false);
}

class AppDialog extends StatelessWidget {
  const AppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement AppDialog
    return Container(
      height: context.height * 0.2,
      width: context.width * 0.8,
      color: Colors.red,
    );
  }
}
