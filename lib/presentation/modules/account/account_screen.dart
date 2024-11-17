import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_strings.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/utils/extension.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/shared/global/app_button.dart';
import 'package:base/presentation/shared/global/app_image.dart';
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
      child: CustomScrollView(controller: controller.scrollController, slivers: [
        Obx(
          () => SliverAppBar(
            collapsedHeight: 80.0,
            expandedHeight: 230.0,
            leading: Visibility(
              visible: !controller.isMyAccount,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
            floating: false,
            pinned: true,
            actions: controller.isAppBarCollapsed.value
                ? [
                    Visibility(
                      visible: !controller.isMyAccount,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: AppButton(
                          text: '+ Follow',
                          height: 30,
                          width: 80,
                          padding: EdgeInsets.all(4),
                          onTap: () {},
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !controller.isMyAccount,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ]
                : null,
            flexibleSpace: FlexibleSpaceBar(
              title: _buildAvatarName(),
              background: _buildBackgroundImage(),
            ),
          ),
        ),
        _buildUserInfo(),
        SliverGrid.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
          itemBuilder: (context, index) {
            return Container(
              height: 20,
              width: 20,
              color: Colors.red,
              child: Center(
                child: Text('Item $index'),
              ),
            );
          },
        )

        // Expanded(child: _buildUserPostMedia()),
      ]),
    );
  }

  _buildBackgroundImage() {
    return Stack(
      children: [
        AppImage(fit: BoxFit.cover, image: NetworkImage(AppStrings.defaultNetworkCover)),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment(0, 0), end: Alignment.bottomCenter, colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.9),
          ])),
        ),
      ],
    );
  }

  _buildAvatarName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 60.0,
          height: 60.0,
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
        Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.appProvider.user.value.displayName ?? '',
                  style: AppTextStyles.s16w700,
                ),
                Text(
                  '@${controller.appProvider.user.value.username}',
                  style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
                ),
              ],
            )),
      ],
    );
  }

  _buildUserInfo() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReach(),
            _buildFollowButton(),
          ],
        ),
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
}
