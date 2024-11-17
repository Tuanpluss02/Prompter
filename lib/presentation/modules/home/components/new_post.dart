import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NewPost extends GetView<HomeController> {
  const NewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAvatarName(),
        _buildPostAction(),
        Divider(),
      ],
    );
  }

  Padding _buildPostAction() {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What\'s news',
            style: AppTextStyles.s14w600.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 10),
          _buildPostInput(),
        ],
      ),
    );
  }

  _buildAvatarName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          onTap: () {},
          child: SvgPicture.asset(
            SvgPath.icImage,
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: 10),
        ScaleButton(
          onTap: () {},
          child: SvgPicture.asset(
            SvgPath.icLink,
            colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
        ),
        SizedBox(width: 10),
        ScaleButton(
          onTap: () {},
          child: Text('#', style: AppTextStyles.s22w400.copyWith(color: Colors.grey)),
        ),
        SizedBox(width: 10),
        ScaleButton(
          onTap: () {},
          child: Text('@', style: AppTextStyles.s22w400.copyWith(color: Colors.grey)),
        ),
      ],
    );
  }
}
