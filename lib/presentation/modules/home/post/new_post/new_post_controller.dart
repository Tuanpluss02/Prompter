import 'dart:io';

import 'package:base/common/utils/image_utils.dart';
import 'package:base/common/utils/permission_check.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/data/page_data/new_post_page_data.dart';
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

class NewPostController extends BaseController {
  final NewPostPageData pageData;
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final PostService _postService = Get.find<PostService>();
  final TextEditingController textController = TextEditingController();
  final FocusNode textFocus = FocusNode();

  final ImagePicker picker = ImagePicker();
  var postImages = <XFile>[].obs;
  var hideLinkPreview = true.obs;
  NewPostController({required this.pageData});
  @override
  void onReady() async {
    await _initData();
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (pageData.type == RouteNewPostType.create) {
        if (pageData.createNewPostPageData!.action == NewPostAction.image) {
          onSelectImage();
        } else {
          textFocus.requestFocus();
        }
      }
    });
  }

  onRemoveImage(int index) {
    postImages.removeAt(index);
    postImages.refresh();
  }

  onSelectImage() async {
    final hasPermission = await checkAndRequestPermission(permission: Permission.photos);
    if (!hasPermission) return;
    final List<XFile> images = await picker.pickMultiImage();
    postImages.addAll(images);
    postImages.refresh();
  }

  onTapPost() async {
    if (textController.text.trim().isEmpty && postImages.isEmpty) {
      showSnackBar(title: 'Please enter content or add image', type: SnackBarType.error);
      return;
    }
    Future<PostEntity> createPost() async {
      List<String> imageUrls = await uploadImage();
      PostEntity post = PostEntity(
        content: textController.text.trim(),
        images: imageUrls,
        authorId: appProvider.user.value.id,
      );
      return await _postService.createPost(post);
    }

    Future<PostEntity> updatePost() async {
      List<String> imageUrls = await uploadImage();
      PostEntity post = pageData.editPostPageData!.postNeedEdit;
      post = post.copyWith(
        content: textController.text.trim(),
        images: imageUrls,
      );
      return await _postService.updatePost(post);
    }

    if (pageData.type == RouteNewPostType.edit) {
      final edittedPost = await CallApiWidget.showLoading<PostEntity>(api: updatePost());
      Get.find<HomeController>().updatePost(edittedPost);
      showSnackBar(title: 'Post updated successfully');
    } else {
      final newPost = await CallApiWidget.showLoading<PostEntity>(api: createPost());
      Get.find<HomeController>().addNewPost(newPost);
      showSnackBar(title: 'Post created successfully');
    }
    Get.until((route) => route.settings.name == AppRoutes.root);
  }

  Future<List<String>> uploadImage() async {
    List<String> imageUrls = [];
    if (postImages.isNotEmpty) {
      imageUrls = await _cloudinaryService.uploadMultipleImages(postImages.map((e) => File(e.path)).toList());
    }
    return imageUrls;
  }

  _initData() async {
    if (pageData.type == RouteNewPostType.edit) {
      textController.text = pageData.editPostPageData!.postNeedEdit.content ?? '';
      postImages.addAll(await ImageUtils.urlToXfile(pageData.editPostPageData!.postNeedEdit.images ?? []));
      postImages.refresh();
    }
  }
}
