import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/domain/data/page_data/new_post_page_data.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/post_image_view.dart';
import 'package:base/presentation/modules/home/components/text_content.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:base/presentation/shared/global/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'new_post_controller.dart';

class NewPostScreen extends BaseScreen<NewPostController> {
  const NewPostScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  bool get wrapWithSafeArea => true;

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
              user: controller.pageData.type != RouteNewPostType.comment ? controller.appProvider.user.value : controller.pageData.commentPostPageData!.newsfeedPost.author,
              showOptions: false,
            ),
          ),
          _buildPostTextEdit(),
          _buildPostMediaContent(),
          SizedBox(height: 10),
          _buildPostInputOption(),
          SizedBox(height: 70),
        ],
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

  _buildImagePreview() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: Get.width * 0.7,
        ),
        child: controller.postImages.length.isEqual(1)
            ? PostImageView(
                image: FileImage(File(controller.postImages.first.path)),
                removeElevation: (
                  showRemoveButton: controller.pageData.type != RouteNewPostType.comment,
                  onTapRemove: () {
                    controller.onRemoveImage(0);
                  },
                ),
              )
            : ListView(
                scrollDirection: Axis.horizontal,
                children: controller.postImages.asMap().entries.map((e) {
                  final index = e.key;
                  final image = File(e.value.path);
                  return PostImageView(
                    image: FileImage(image),
                    removeElevation: (
                      showRemoveButton: controller.pageData.type != RouteNewPostType.comment,
                      onTapRemove: () {
                        controller.onRemoveImage(index);
                      },
                    ),
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
    return Visibility(
      visible: controller.pageData.type != RouteNewPostType.comment,
      child: Padding(
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
      ),
    );
  }

  _buildPostMediaContent() {
    return Obx(() => Visibility(
          visible: controller.postImages.isNotEmpty,
          // replacement: _buildLinkPreview(),
          child: _buildImagePreview(),
        ));
  }

  _buildPostTextEdit() {
    return Padding(
        padding: const EdgeInsets.only(left: 90),
        child: () {
          if (controller.pageData.type == RouteNewPostType.comment) {
            return Visibility(
              visible: controller.pageData.commentPostPageData!.newsfeedPost.post.content?.isNotEmpty ?? false,
              child: TextContent(
                content: controller.pageData.commentPostPageData!.newsfeedPost.post.content,
              ),
            );
          }
          return TextField(
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
            ),
          );
        }());
  }
}
