import 'dart:typed_data';

import 'package:base/common/utils/log.dart';
import 'package:base/common/utils/permission_check.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUtils {
  static Future<XFile> getImageXFileByUrl(String url) async {
    var file = await DefaultCacheManager().getSingleFile(url);
    XFile result = XFile(file.path);
    return result;
  }

  static Future<void> saveImageToGallery({required String imageUrl}) async {
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
        Fluttertoast.showToast(msg: "Image saved to gallery.");
      } else {
        Log.console("Failed to save image.");
      }
    } catch (e) {
      Log.console("Error saving image: $e");
    }
  }

  static Future<List<XFile>> urlToXfile(List<String> urls) async {
    List<XFile> xFiles = [];
    for (var url in urls) {
      xFiles.add(await getImageXFileByUrl(url));
    }
    return xFiles;
  }
}
