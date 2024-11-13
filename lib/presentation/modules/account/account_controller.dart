import 'package:base/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends BaseController
    with GetTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
