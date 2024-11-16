import 'package:base/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountController extends BaseController with GetTickerProviderStateMixin {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  late final TabController tabController;

  final String? userId;

  AccountController({this.userId});

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  onRefresh() async {
    await appProvider.getUserInfomation(userId: userId);
    refreshController.refreshCompleted();
  }
}
