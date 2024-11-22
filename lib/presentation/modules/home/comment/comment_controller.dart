import 'dart:io';

import 'package:base/common/constants/app_type.dart';
import 'package:base/common/utils/permission_check.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/comment_entity.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/shared/utils/call_api_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommentController extends BaseController {
  final NewsFeedPost newsFeedPost;
  final TextEditingController commentTextController = TextEditingController();
  final RefreshController postDetailRefreshController = RefreshController();
  final CloudinaryService _cloudinaryService = Get.find<CloudinaryService>();
  final PostService _postService = Get.find<PostService>();
  final UserService _userService = Get.find<UserService>();

  var commentList = <PostComment>[].obs;
  final TextEditingController textController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  var userCommentImage = <XFile>[].obs;

  CommentController({required this.newsFeedPost});

  Future<void> addComment() async {
    FocusScope.of(Get.context!).unfocus();
    if (commentTextController.text.isEmpty && userCommentImage.isEmpty) {
      showSnackBar(title: 'Please enter a comment or select an image', type: SnackBarType.error);
      return;
    }
    Future<CommentEntity> process() async {
      List<String> imageUrls = [];
      if (userCommentImage.isNotEmpty) {
        imageUrls = await _cloudinaryService.uploadMultipleImages(userCommentImage.map((e) => File(e.path)).toList());
      }
      final comment = CommentEntity(
        authorId: appProvider.user.value.id,
        content: commentTextController.text,
        images: imageUrls,
      );
      return await _postService.addComment(appProvider.user.value.id!, newsFeedPost.post.id!, comment);
    }

    final newComment = await CallApiWidget.showLoading(api: process());
    commentTextController.clear();
    userCommentImage.clear();
    userCommentImage.refresh();
    commentList.insert(0, PostComment(comment: newComment, author: appProvider.user.value));
    commentList.refresh();
  }

  Future<List<PostComment>> getComments(String postId) async {
    final commentList = <PostComment>[];
    final comments = await _postService.getCommentsByPostId(postId);
    for (final post in comments) {
      final author = await _userService.getUserById(post.authorId ?? '');
      commentList.add(PostComment(comment: post, author: author!));
    }
    return commentList;
  }

  bool isCommentLiked(PostComment postComment) {
    return postComment.comment.likes?.contains(appProvider.user.value.id) ?? false;
  }

  onRemoveImage(int index) {
    userCommentImage.removeAt(index);
    userCommentImage.refresh();
  }

  onSelectImage() async {
    final hasPermission = await checkAndRequestPermission(permission: Permission.photos);
    if (!hasPermission) return;
    List<XFile> images = await picker.pickMultiImage();
    if (images.isEmpty) return;
    if (images.length > 5) {
      showSnackBar(title: 'You can only select up to 5 images', type: SnackBarType.error);
      images = images.sublist(0, 5);
    }
    userCommentImage.addAll(images);
    userCommentImage.refresh();
  }
}
