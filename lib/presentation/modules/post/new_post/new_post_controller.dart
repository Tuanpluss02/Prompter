import 'package:base/common/utils/permission_check.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

enum NewPostAction {
  text,
  image,
  link,
  hastag,
  mention,
}

class NewPostController extends BaseController {
  final NewPostAction action;

  NewPostController({required this.action});
  final ImagePicker picker = ImagePicker();
  var postImages = <XFile>[].obs;
  var hideLinkPreview = false.obs;
  onSelectImage() async {
    final hasPermission = await checkAndRequestPermission(permission: Permission.photos);
    if (!hasPermission) return;
    final List<XFile> images = await picker.pickMultiImage();
    postImages.addAll(images);
    postImages.refresh();
  }
}
