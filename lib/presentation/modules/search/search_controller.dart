import 'package:base/common/utils/deboucer.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:base/domain/services/post_service.dart';
import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';

class SearchController extends BaseController {
  final TextEditingController searchController = TextEditingController();
  final UserService _userService = UserService();
  final PostService _postService = PostService();
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  final searchResults = <dynamic>[].obs;

  Future<void> searchUsers(String query) async {
    final users = await _userService.searchUsers(query);
    searchResults.addAll(users);
  }

  Future<void> searchPosts(String query) async {
    final posts = await _postService.searchPosts(query);
    searchResults.addAll(posts);
  }

  void onSearchChanged(String query) {
    debouncer.run(() async {
      searchResults.clear();
      await searchUsers(query);
      await searchPosts(query);
    });
  }
}
