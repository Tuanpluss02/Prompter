import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_strings.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/utils/extension.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/widgets/global/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'account_controller.dart';

class AccountScreen extends BaseScreen<AccountController> {
  const AccountScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          _buildFirstSection(),
          _buildUserInfo(),
          // Expanded(child: _buildUserPostMedia()),
        ]),
      ),
    );
  }

  SizedBox _buildFirstSection() {
    return SizedBox(
      height: 230,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: [
          _buildBackgroundImg(),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment(0, 0.2), end: Alignment.bottomCenter, colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.6),
            ])),
          ),
          _buildAvatarName(),
        ],
      ),
    );
  }

  Align _buildAvatarName() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: NetworkImage(AppStrings.defaultNetworkAvatar),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.appProvider.user.value.displayName ?? '',
                  style: AppTextStyles.s24w700,
                ),
                Text(
                  '@${controller.appProvider.user.value.username}',
                  style: AppTextStyles.s16w400.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppImage _buildBackgroundImg() {
    return AppImage(fit: BoxFit.contain, image: NetworkImage(AppStrings.defaultNetworkCover));
  }

  _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildReach(),
          _buildFollowButton(),
        ],
      ),
    );
  }

  Row _buildReach() {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (count: controller.appProvider.user.value.likeCount ?? 0, title: 'Likes'),
          (count: controller.appProvider.user.value.followers?.length ?? 0, title: 'Followers'),
          (count: controller.appProvider.user.value.followers?.length ?? 0, title: 'Following'),
        ].map((item) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${item.count.toShortString()} ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  TextSpan(
                    text: item.title,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        }).toList());
  }

  _buildFollowButton() {
    return Visibility(
      visible: controller.userId != controller.appProvider.user.value.id,
      replacement: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '+ Follow',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildUserPostMedia() {
    return Column(
      children: [
        SizedBox(
          width: Get.width * 0.6,
          child: TabBar(dividerColor: Colors.transparent, controller: controller.tabController, tabs: [
            Tab(
              child: Text('All', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            Tab(
              child: Text('Videos', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            Tab(
              child: Text('Images', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ]),
        ),
        TabBarView(controller: controller.tabController, children: [
          _buildAllMedia(),
          _buildVideos(),
          _buildImages(),
        ]),
      ],
    );
  }

  _buildAllMedia() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            child: Center(
              child: Text('Item $index'),
            ),
          );
        });
  }

  _buildVideos() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            child: Center(
              child: Text('Item $index'),
            ),
          );
        });
  }

  _buildImages() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey,
            child: Center(
              child: Text('Item $index'),
            ),
          );
        });
  }
}
