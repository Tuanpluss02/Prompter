import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/modules/home/post/new_post/new_post_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WhatsNewsSection extends GetView<HomeController> {
  const WhatsNewsSection({super.key});

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() => UserSection(user: controller.appProvider.user.value)),
            ),
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
