import 'package:base/common/constants/app_type.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:base/presentation/modules/root/root_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountController extends BaseController with GetTickerProviderStateMixin {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();
  final PostService _postService = Get.find<PostService>();

  var isAppBarCollapsed = false.obs;

  var userPosts = <NewsFeedPost>[].obs;

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
    await Get.find<RootController>().getCurrentUserData();
    String userId = appProvider.currentUserId;
    List<PostEntity> posts = await _postService.getPostsByUserId(userId);
    List<NewsFeedPost> newsFeedPosts = [];
    for (PostEntity post in posts) {
      newsFeedPosts.add(NewsFeedPost(author: appProvider.user.value, post: post));
    }
    userPosts.value = newsFeedPosts;
    update(['reach_info']);
  }
}
