import 'dart:typed_data';

import 'package:base/app/utils/log.dart';
import 'package:base/app/utils/permission_check.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> saveImageToGallery({required String imageUrl}) async {
  bool hasPermission = await checkAndRequestPermission(permission: Permission.storage);
  if (!hasPermission) {
    return;
  }

  try {
    var response = await Dio().get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );

    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 100,
      name: "image_${DateTime.now().millisecondsSinceEpoch}",
    );

    if (result != null && result["isSuccess"]) {
      Log.console("Image saved to gallery!");
    } else {
      Log.console("Failed to save image.");
    }
  } catch (e) {
    Log.console("Error saving image: $e");
  }
}
