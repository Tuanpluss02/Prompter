import 'package:base/common/constants/app_type.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends BaseController {
  final TextEditingController searchController = TextEditingController();
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
  }

  Future<void> searchUsers(String query) async {
    final users = await _userService.searchUsers(query);
    searchUserResults.addAll(users);
  }
}
