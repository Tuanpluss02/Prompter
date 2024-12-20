import 'dart:io';
import 'dart:typed_data';

import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/utils/generate_id.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:path_provider/path_provider.dart';

class CloudinaryService {
  static final CloudinaryService _cloudinaryService = CloudinaryService._internal();
  factory CloudinaryService() => _cloudinaryService;

  CloudinaryService._internal();
  final cloudinary = Cloudinary.signedConfig(
    apiKey: AppStrings.cloudinaryApiKey,
    apiSecret: AppStrings.cloudinaryApiSecret,
    cloudName: AppStrings.cloudinaryName,
  );

  Future<String?> uploadImage(Uint8List bytes) async {
    final file = await _convertUint8ListToFile(bytes, '${generateUniqueId()}.jpg');
    final response = await cloudinary.upload(
      file: file.path,
      fileBytes: file.readAsBytesSync(),
      resourceType: CloudinaryResourceType.image,
      folder: 'images',
      fileName: 'AI-Image-Generated ${DateTime.now().millisecondsSinceEpoch}',
    );

    if (response.isSuccessful) {
      return response.secureUrl;
    } else {
      return null;
    }
  }

  Future<List<String>> uploadMultipleImages(List<File> files) async {
    final List<String> imageLinks = [];
    for (var file in files) {
      final response = await cloudinary.upload(
        file: file.path,
        fileBytes: file.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: 'images',
        fileName: generateUniqueId(),
      );
      if (response.isSuccessful) {
        imageLinks.add(response.secureUrl ?? '');
      }
    }
    return imageLinks;
  }
}

Future<File> _convertUint8ListToFile(Uint8List bytes, String fileName) async {
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/$fileName');
  return await file.writeAsBytes(bytes);
}
