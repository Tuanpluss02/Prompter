import 'dart:io';

import 'package:base/common/constants/app_type.dart';
import 'package:base/common/utils/image_utils.dart';
import 'package:base/common/utils/permission_check.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/comment_entity.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/shared/global/app_dialog.dart';
import 'package:base/presentation/shared/global/app_overlay.dart';
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
  final FocusNode commentFocusNode = FocusNode();
  final PostService _postService = Get.find<PostService>();
  final UserService _userService = Get.find<UserService>();

  var commentList = <PostComment>[].obs;
  final ImagePicker picker = ImagePicker();
  var userCommentImage = <XFile>[].obs;
  var commentIdEditing = ''.obs;

  CommentController({required this.newsFeedPost});

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

  bool isCommentOwner(PostComment postComment) {
    return postComment.author.id == appProvider.user.value.id;
  }

  Future<void> likeComment(PostComment postComment) async {
    final isLiked = isCommentLiked(postComment);
    final index = commentList.indexWhere((element) => element.comment.id == postComment.comment.id);
    if (isLiked) {
      commentList[index].comment.likes?.remove(appProvider.user.value.id);
    } else {
      commentList[index].comment.likes?.add(appProvider.user.value.id ?? '');
    }
    update(['comment_${postComment.comment.id!}']);
    _postService.updateCommentLike(appProvider.user.value.id ?? '', postComment.comment.id ?? '');
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

  Future<void> onSubmit() async {
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
      CommentEntity comment = CommentEntity();
      final edittingComment = commentList.firstWhereOrNull((element) => element.comment.id == commentIdEditing.value);
      if (edittingComment != null) {
        comment = edittingComment.comment;
      }
      comment = comment.copyWith(
        authorId: appProvider.user.value.id,
        content: commentTextController.text,
        images: imageUrls,
      );
      if (commentIdEditing.value.isEmpty) return await _postService.addComment(appProvider.user.value.id!, newsFeedPost.post.id!, comment);
      return await _postService.updateComment(comment);
    }

    final comment = await AppOverlay.showLoading(api: process());

    if (commentIdEditing.isEmpty) {
      commentList.insert(0, PostComment(comment: comment, author: appProvider.user.value));
    } else {
      commentIdEditing.value = '';
      commentList.firstWhere((element) => element.comment.id == comment.id).comment = comment;
      update(['comment_${comment.id}']);
    }
    commentTextController.clear();
    userCommentImage.clear();
    userCommentImage.refresh();
    Get.find<HomeController>().updateCommentList(newsFeedPost.post, comment);
    update(['post_comment_${newsFeedPost.post.id}']);
    commentList.refresh();
  }

  void onTapDeleteComment(PostComment postComment) async {
    Get.back();
    final isConfirmed = await Get.dialog<bool>(AppDialog(
      title: 'Delete Comment',
      content: 'Are you sure to delete this comment?',
      primaryButtonText: 'Delete',
      secondaryButtonText: 'Cancel',
      onPrimaryButtonTap: () => Get.back(result: true),
      onSecondaryButtonTap: () => Get.back(result: false),
    ));
    if (isConfirmed != true) {
      return;
    }

    Future<void> process() async {
      Get.find<HomeController>().updateCommentList(newsFeedPost.post, postComment.comment, isDeleteComment: true);
      commentList.removeWhere((element) => element.comment.id == postComment.comment.id);
      _postService.deleteComment(newsFeedPost.post.id!, postComment.comment.id!);
    }

    await AppOverlay.showLoading(api: process());
    update(['post_comment_${newsFeedPost.post.id}']);
    showSnackBar(title: 'Comment deleted successfully', type: SnackBarType.success);
  }

  onTapEditComment(PostComment postComment) async {
    Get.back();
    Future<void> loadData() async {
      commentTextController.text = postComment.comment.content ?? '';
      userCommentImage.addAll(await ImageUtils.urlToXfile(postComment.comment.images ?? []));
    }

    await AppOverlay.showLoading(api: loadData());
    commentIdEditing.value = postComment.comment.id ?? '';
    userCommentImage.refresh();
    commentFocusNode.requestFocus();
  }
}
