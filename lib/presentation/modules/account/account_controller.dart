import 'package:base/app/utils/log.dart';
import 'package:base/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountController extends BaseController with GetTickerProviderStateMixin {
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  final ScrollController scrollController = ScrollController();

  late final TabController tabController;

  final String? userId;
  bool get isMyAccount => userId == null;

  AccountController({this.userId});
  var isAppBarCollapsed = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    scrollController.addListener(() {
      double offset = scrollController.offset;
      if (offset >= 80) {
        isAppBarCollapsed.value = true;
        Log.console('AppBar collapsed');
      } else {
        isAppBarCollapsed.value = false;
        Log.console('AppBar expanded');
      }
    });
  }

  onRefresh() async {
    await appProvider.getUserInfomation(userId: userId);
    refreshController.refreshCompleted();
  }
}
