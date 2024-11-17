import 'package:base/common/constants/app_strings.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/create_post_view.dart';
import 'package:base/presentation/modules/home/components/post_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: CreatePostView()),
          Obx(() => controller.newsFeed.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => PostView(post: controller.newsFeed[index]),
                    childCount: controller.newsFeed.length,
                  ),
                )
              : SliverFillRemaining(
                  child: Center(
                    child: Text('No post found'),
                  ),
                )),
        ],
      ),
    );
  }
}
