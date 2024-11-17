import 'package:base/common/constants/app_strings.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/post_view.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  bool get wrapWithSafeArea => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppStrings.appName.toUpperCase(), style: TextStyle(fontFamily: 'Larsseit', fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 5)),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      // child: ListView.builder(itemBuilder: controller.itemBuilder, itemCount: controller.itemCount),
      child: Column(
        children: [
          const SizedBox(height: 20),
          PostView(
            post: controller.posts[0],
          ),
        ],
      ),
    );
  }
}
