import 'package:base/common/constants/app_type.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountController extends BaseController with GetTickerProviderStateMixin {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final UserService _userService = Get.find<UserService>();
  final PostService _postService = Get.find<PostService>();

  var isAppBarCollapsed = false.obs;

  var userPosts = <NewsFeedPost>[].obs;
  var userData = UserEntity().obs;

  @override
  void onInit() {
    super.onInit();
    _initData();
    scrollController.addListener(() {
      double offset = scrollController.offset;
      if (offset >= 80) {
        isAppBarCollapsed.value = true;
      } else {
        isAppBarCollapsed.value = false;
      }
    });
  }

  onRefresh() async {
    await _initData();
    refreshController.refreshCompleted();
  }

  _initData() async {
    String userId = appProvider.currentUserId;
    userData.value = await _userService.getUserById(userId) ?? UserEntity();
    List<PostEntity> posts = await _postService.getPostsByUserId(userId);
    List<NewsFeedPost> newsFeedPosts = [];
    for (PostEntity post in posts) {
      newsFeedPosts.add(NewsFeedPost(author: userData.value, post: post));
    }
    userPosts.value = newsFeedPosts;
  }
}
