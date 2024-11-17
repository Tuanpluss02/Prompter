import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/modules/post/new_post/new_post_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CreatePostView extends GetView<HomeController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () => Get.toNamed(AppRoutes.newPost, arguments: NewPostAction.text),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildAvatarName(),
            _buildPostAction(),
            Divider(),
          ],
        ),
      ),
    );
  }

  Padding _buildPostAction() {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'What\'s news',
              style: AppTextStyles.s14w600.copyWith(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 10),
          _buildPostInput(),
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

  _buildPostInput() {
    return Row(
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
    );
  }
}
