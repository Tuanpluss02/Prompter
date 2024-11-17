import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'new_post_controller.dart';

class NewPostScreen extends BaseScreen<NewPostController> {
  const NewPostScreen({super.key});

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAppBar(),
          Divider(),
          _buildAvatarName(),
          _buildPostAction(),
          _buildPostInputOption(),
        ],
      ),
    );
  }

  Padding _buildPostAction() {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 300.0,
        ),
        child: TextField(
            maxLines: null,
            maxLength: 5000,
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            style: AppTextStyles.s14w600.copyWith(color: Colors.white),
            decoration: InputDecoration(
              counterText: '',
              hintText: 'What\'s news',
              hintStyle: AppTextStyles.s14w600.copyWith(color: Colors.grey),
              border: InputBorder.none,
            )),
      ),
    );
  }

  _buildAppBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppBackButton(
            size: 40,
            margin: EdgeInsets.zero,
          ),
          Text(
            'New Post',
            style: AppTextStyles.s16w700,
          ),
          SizedBox(width: 60),
        ],
      ),
    );
  }

  _buildAvatarName() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
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
      ),
    );
  }

  _buildPostInputOption() {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: Row(
        children: [
          ScaleButton(
            onTap: () => Get.toNamed(AppRoutes.newPost, arguments: NewPostAction.image),
            child: SvgPicture.asset(
              SvgPath.icImage,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 10),
          ScaleButton(
            onTap: () => Get.toNamed(AppRoutes.newPost, arguments: NewPostAction.link),
            child: SvgPicture.asset(
              SvgPath.icLink,
              colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            ),
          ),
          SizedBox(width: 10),
          ScaleButton(
            onTap: () => Get.toNamed(AppRoutes.newPost, arguments: NewPostAction.hastag),
            child: Text('#', style: AppTextStyles.s22w400.copyWith(color: Colors.grey)),
          ),
          SizedBox(width: 10),
          ScaleButton(
            onTap: () => Get.toNamed(AppRoutes.newPost, arguments: NewPostAction.mention),
            child: Text('@', style: AppTextStyles.s22w400.copyWith(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
