import 'dart:io';

import 'package:base/common/utils/permission_check.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/utils/call_api_widget.dart';
import 'package:flutter/material.dart';
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
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final PostService _postService = Get.find<PostService>();
  final TextEditingController textController = TextEditingController();

  NewPostController({required this.action});
  final ImagePicker picker = ImagePicker();
  var postImages = <XFile>[].obs;
  var hideLinkPreview = true.obs;
  onSelectImage() async {
    final hasPermission = await checkAndRequestPermission(permission: Permission.photos);
    if (!hasPermission) return;
    final List<XFile> images = await picker.pickMultiImage();
    postImages.addAll(images);
    postImages.refresh();
  }

  onRemoveImage(int index) {
    postImages.removeAt(index);
    postImages.refresh();
  }

  onTapPost() async {
    if (textController.text.trim().isEmpty && postImages.isEmpty) {
      return;
    }
    Future<PostEntity> process() async {
      List<String> imageUrls = [];
      if (postImages.isNotEmpty) {
        imageUrls = await _cloudinaryService.uploadMultipleImages(postImages.map((e) => File(e.path)).toList());
      }
      PostEntity post = PostEntity(
        content: textController.text.trim(),
        images: imageUrls,
        authorId: appProvider.user.value.id,
      );
      return await _postService.createPost(post);
    }

    final newPost = await CallApiWidget.showLoading<PostEntity>(api: process());
    Get.find<HomeController>().addNewPost(newPost);
    showSnackBar(title: 'Post created successfully');
    Get.until((route) => route.settings.name == AppRoutes.root);
  }
}
