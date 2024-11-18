import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:base/presentation/shared/global/app_button.dart';
import 'package:base/presentation/shared/global/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'new_post_controller.dart';

class NewPostScreen extends BaseScreen<NewPostController> {
  const NewPostScreen({super.key});

  @override
  bool get wrapWithSafeArea => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: AppButton(
        text: 'Post',
        height: 50,
        onTap: () => controller.onTapPost(),
        margin: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildAppBar(),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: UserSection(
              user: controller.appProvider.user.value,
              showOptions: false,
            ),
          ),
          _buildPostTextContent(),
          _buildPostMediaContent(),
          SizedBox(height: 10),
          _buildPostInputOption(),
          SizedBox(height: 70),
        ],
      ),
    );
  }

  _buildPostTextContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.width * 0.6,
        ),
        child: TextField(
            controller: controller.textController,
            maxLines: null,
            maxLength: 5000,
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            style: AppTextStyles.s14w400.copyWith(color: Colors.white),
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

  _buildPostMediaContent() {
    return Obx(() => Visibility(
          visible: controller.postImages.isNotEmpty,
          replacement: _buildLinkPreview(),
          child: _buildImagePreview(),
        ));
  }

  Container _buildImagePreview() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: controller.postImages.length.isEqual(1) ? Get.width * 0.7 : Get.width * 0.5,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: controller.postImages.asMap().entries.map((e) {
            final index = e.key;
            final image = File(e.value.path);
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AppImage(image: FileImage(image)),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 20,
                  child: ScaleButton(
                    onTap: () => controller.onRemoveImage(index),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  _buildLinkPreview() {
    return Visibility(
      visible: !controller.hideLinkPreview.value,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            AnyLinkPreview(
              link: "https://facebook.com/",
              removeElevation: true,
            ),
            Positioned(
              top: 10,
              right: 10,
              child: ScaleButton(
                onTap: () {
                  controller.hideLinkPreview.value = true;
                },
                child: Container(
                  width: 25,
                  height: 25,
                  // padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    // size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPostInputOption() {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: Row(
        children: [
          ScaleButton(
            onTap: controller.onSelectImage,
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