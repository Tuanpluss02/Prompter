import 'package:base/common/constants/app_type.dart';
import 'package:base/common/utils/snackbar.dart';
import 'package:base/domain/data/entities/comment_entity.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/modules/account/account_controller.dart';
import 'package:base/presentation/shared/global/app_dialog.dart';
import 'package:base/presentation/shared/utils/call_api_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  final RefreshController newsFeedRefreshController = RefreshController();
  final RefreshController postDetailRefreshController = RefreshController();
  final PostService _postService = Get.find<PostService>();
  final UserService _userService = Get.find<UserService>();
  final newsFeed = <NewsFeedPost>[].obs;

  addNewPost(PostEntity post) async {
    final author = await _userService.getUserById(post.authorId ?? '');
    newsFeed.insert(0, NewsFeedPost(post: post, author: author!));
    newsFeed.refresh();
  }

  void deletePost(String postId) async {
    Get.back();
    final isConfirmed = await Get.dialog<bool>(PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => Get.back(result: false),
      child: AppDialog(
        title: 'Delete Post',
        content: 'Are you sure to detele this post?',
        primaryButtonText: 'Delete',
        secondaryButtonText: 'Cancel',
        onPrimaryButtonTap: () => Get.back(result: true),
        onSecondaryButtonTap: () => Get.back(result: false),
      ),
    ));
    if (isConfirmed != true) {
      return;
    }
    Future<void> process() async {
      await _postService.deletePost(postId);
      newsFeed.removeWhere((element) => element.post.id == postId);
      Get.find<AccountController>().userPosts.removeWhere((element) => element.post.id == postId);
    }

    CallApiWidget.showLoading(api: process());
    newsFeed.refresh();
    Get.find<AccountController>().userPosts.refresh();
    showSnackBar(title: 'Post deleted successfully', type: SnackBarType.success);
  }

  getNewsFeed({bool mustRefresh = false}) async {
    final List<PostEntity> posts = await _postService.getNewsFeed();
    newsFeed.clear();
    for (final post in posts) {
      final author = await _userService.getUserById(post.authorId ?? '');
      newsFeed.add(NewsFeedPost(post: post, author: author!));
    }
    if (mustRefresh) newsFeed.refresh();
  }

  bool isPostLiked(NewsFeedPost news) {
    return news.post.likes?.contains(appProvider.user.value.id) ?? false;
  }

  likePost(NewsFeedPost postToLike) async {
    final isLiked = isPostLiked(postToLike);
    final index = newsFeed.indexWhere((element) => element.post.id == postToLike.post.id);
    if (isLiked) {
      newsFeed[index].post.likes?.remove(appProvider.user.value.id);
    } else {
      newsFeed[index].post.likes?.add(appProvider.user.value.id ?? '');
    }
    update(['post_${postToLike.post.id!}']);
    _postService.updatePostLike(appProvider.user.value.id ?? '', postToLike.post.id ?? '');
  }

  @override
  void onReady() {
    getNewsFeed();
    super.onReady();
  }

  void onRefresh() async {
    await getNewsFeed();
    newsFeedRefreshController.refreshCompleted();
  }

  updateCommentList(PostEntity post, CommentEntity comment, {bool isDeleteComment = false}) {
    final index = newsFeed.indexWhere((element) => element.post.id == post.id);
    if (isDeleteComment) {
      newsFeed[index].post.comments?.remove(comment.id);
    } else {
      newsFeed[index].post.comments?.add(comment.id ?? '');
    }
    update(['post_${post.id!}']);
  }

  void updatePost(PostEntity postNeedEdit) {
    final index = newsFeed.indexWhere((element) => element.post.id == postNeedEdit.id);
    newsFeed[index].post = postNeedEdit;
    update(['post_${postNeedEdit.id!}']);
    newsFeed.refresh();
  }
}
