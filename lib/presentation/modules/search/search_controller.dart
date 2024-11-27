import 'package:base/common/constants/app_type.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends BaseController {
  final TextEditingController textSearchController = TextEditingController();
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  final searchPostResults = <NewsFeedPost>[].obs;
  final searchUserResults = <UserEntity>[].obs;

  void onSearchChanged(String query) async {
    searchUserResults.clear();
    searchPostResults.clear();
    await searchUsers(query);
    await searchPosts(query);
    searchPostResults.refresh();
    searchUserResults.refresh();
  }

  Future<void> searchPosts(String query) async {
    final posts = await _postService.searchPosts(query);
    for (final post in posts) {
      final author = await _userService.getUserById(post.authorId!);
      searchPostResults.add(NewsFeedPost(author: author!, post: post));
    }
    searchPostResults.sort((a, b) {
      // Like count -> comment count -> time created
      final aLikeCount = a.post.likes?.length ?? 0;
      final bLikeCount = b.post.likes?.length ?? 0;
      final aCommentCount = a.post.comments?.length ?? 0;
      final bCommentCount = b.post.comments?.length ?? 0;
      final aTime = a.post.createdAt ?? DateTime.now();
      final bTime = b.post.createdAt ?? DateTime.now();
      if (aLikeCount != bLikeCount) {
        return bLikeCount.compareTo(aLikeCount);
      } else if (aCommentCount != bCommentCount) {
        return bCommentCount.compareTo(aCommentCount);
      } else {
        return bTime.compareTo(aTime);
      }
    });
  }

  Future<void> searchUsers(String query) async {
    final users = await _userService.searchUsers(query);
    searchUserResults.addAll(users);
    searchUserResults.sort((a, b) {
      // followers count -> posts count
      final aPostsCount = a.postCount ?? 0;
      final bPostsCount = b.postCount ?? 0;
      final aFollowersCount = a.followers?.length ?? 0;
      final bFollowersCount = b.followers?.length ?? 0;
      if (aFollowersCount != bFollowersCount) {
        return bFollowersCount.compareTo(aFollowersCount);
      } else {
        return bPostsCount.compareTo(aPostsCount);
      }
    });
  }
}
