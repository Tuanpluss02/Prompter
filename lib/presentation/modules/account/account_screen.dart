import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/post/post_view.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        _buildAppbar(),
        _buildUserInfo(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              'Posts',
              style: AppTextStyles.s16w700,
            ),
          ),
        ),
        _buildUserPosts(),
      ]),
    );
  }

  _buildAppbar() {
    return SliverAppBar(
      collapsedHeight: 80.0,
      expandedHeight: 230.0,
      floating: false,
      pinned: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.preferences),
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ],
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: _buildAvatarName(),
        background: _buildBackgroundImage(),
      ),
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
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          child: Obx(() => ClipOval(
                  child: Image(
                image: ExtendedNetworkImageProvider(controller.appProvider.user.value.profileImage ?? ''),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => SvgPicture.asset(SvgPath.icPersonFilled),
              ))),
        ),
        SizedBox(width: 10),
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

  _buildBackgroundImage() {
    return Stack(
      children: [
        AppImage(fit: BoxFit.cover, image: NetworkImage(AppStrings.defaultNetworkCover)),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment(0, 0), end: Alignment.bottomCenter, colors: [
            Colors.transparent,
            Colors.black.withValues(alpha: 0.9),
          ])),
        ),
      ],
    );
  }

  _buildFollowButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScaleButton(
        onTap: () => Get.toNamed(AppRoutes.changeUserInfo),
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
    );
  }

  _buildReach() {
    return GetBuilder<AccountController>(
      init: controller,
      id: 'reach_info',
      initState: (_) {},
      builder: (_) {
        return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (count: controller.appProvider.user.value.followers?.length ?? 0, title: 'Followers'),
              (count: controller.appProvider.user.value.following?.length ?? 0, title: 'Following'),
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
      },
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

  Obx _buildUserPosts() {
    return Obx(() => controller.userPosts.isNotEmpty
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  PostView(news: controller.userPosts[index]),
                  Divider(),
                ],
              ),
              childCount: controller.userPosts.length,
            ),
          )
        : SliverFillRemaining(
            child: Center(
              child: Text('No post found'),
            ),
          ));
  }
}
