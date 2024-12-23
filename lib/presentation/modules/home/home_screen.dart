import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/post/post_view.dart';
import 'package:base/presentation/modules/home/post/whats_news_section.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text(
        AppStrings.appName.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Larsseit',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 5,
        ),
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            SvgPath.icSettings,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          onPressed: () => Get.toNamed(AppRoutes.preferences),
        ),
      ],
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SmartRefresher(
      controller: controller.newsFeedRefreshController,
      onRefresh: controller.onRefresh,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: WhatsNewsSection()),
          Obx(() => controller.newsFeed.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Column(
                      children: [
                        PostView(news: controller.newsFeed[index]),
                        Divider(),
                      ],
                    ),
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
