import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_type.dart';
import 'package:base/common/utils/permission_check.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/comment_entity.dart';
import 'package:base/domain/services/cloudinary_service.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/presentation/base/base_controller.dart';
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
  var commentList = <PostComment>[].obs;
  final TextEditingController textController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  var userCommentImage = <XFile>[].obs;

  CommentController({required this.newsFeedPost});

  Future<List<PostComment>> getComments(String postId) async {
    List<PostComment> comments = [
      PostComment(
          comment: CommentEntity(
            id: '23hr92hfe9un934hb23',
            authorId: "Dw5wgm3HeiaFuOj4Daf6c03h7Xj1",
            content: 'This is a comment',
            createdAt: DateTime.now(),
          ),
          author: appProvider.user.value),
      PostComment(
          comment: CommentEntity(
            id: '23hr92hfe9un934hb23',
            authorId: "Dw5wgm3HeiaFuOj4Daf6c03h7Xj1",
            content: 'This is a comment',
            createdAt: DateTime.now(),
          ),
          author: appProvider.user.value),
      PostComment(
          comment: CommentEntity(
            id: '23hr92hfe9un934hb23',
            authorId: "Dw5wgm3HeiaFuOj4Daf6c03h7Xj1",
            content: 'This is a comment',
            createdAt: DateTime.now(),
          ),
          author: appProvider.user.value),
      PostComment(
          comment: CommentEntity(
            id: 'fhr9248f21h023hf2f',
            authorId: "Dw5wgm3HeiaFuOj4Daf6c03h7Xj1",
            content: 'This is another comment',
            images: [
              AppStrings.defaultNetworkCover,
              AppStrings.defaultNetworkAvatar,
            ],
            createdAt: DateTime.now(),
          ),
          author: appProvider.user.value),
    ];
    return comments;
    // return await _postService.getCommentsByPostId(postId);
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
