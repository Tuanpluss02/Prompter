import 'package:base/domain/services/user_service.dart';
import 'package:base/presentation/base/base_controller.dart';
import 'package:flutter/material.dart';

class SearchController extends BaseController {
  final TextEditingController searchController = TextEditingController();
  final UserService _userService = UserService();
}
