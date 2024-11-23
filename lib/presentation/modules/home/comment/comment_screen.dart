import 'dart:io';

import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/comment_section.dart';
import 'package:base/presentation/modules/home/components/post_image_view.dart';
import 'package:base/presentation/modules/home/components/post_input_action.dart';
import 'package:base/presentation/modules/home/post/post_view.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'comment_controller.dart';

class CommentScreen extends BaseScreen<CommentController> {
  const CommentScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;
  @override
  Color get screenBackgroundColor => AppColors.backgroundColor;
  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => _buildAppBar();

  @override
  Widget? buildBottomNavigationBar(BuildContext context) => _buildCommentAction(context);

  @override
  Widget buildScreen(BuildContext context) {
    return SmartRefresher(
      controller: controller.postDetailRefreshController,
      onRefresh: () {
        controller.getComments(controller.newsFeedPost.post.id!);
        controller.postDetailRefreshController.refreshCompleted();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostView(news: controller.newsFeedPost),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Comments',
                  style: AppTextStyles.s16w600,
                ),
              ),
              Divider(),
              CommentSection(postId: controller.newsFeedPost.post.id!),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: Text('Post Detail'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  _buildCommentAction(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.dialogBackgroundColor,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildImagePreview(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PostInputAction(
                onTapImage: controller.onSelectImage,
                onTapLink: () {},
                onTapMention: () {},
                onTapHastag: () {},
              ),
              Obx(() => Visibility(
                    visible: controller.commentIdEditing.isNotEmpty,
                    child: Row(
                      children: [
                        Text('You are editing a comment', style: AppTextStyles.s11w600.copyWith(color: Colors.grey)),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              controller.commentTextController.clear();
                              controller.userCommentImage.clear();
                              controller.commentIdEditing.value = '';
                            },
                            child: Transform.rotate(
                              angle: 45 * 3.1415926535897932 / 180,
                              child: SvgPicture.asset(
                                width: 10,
                                SvgPath.icAdd,
                                colorFilter: ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              // ListTile(
              //   trailing: GestureDetector(
              //     onTap: () {
              //       controller.commentTextController.clear();
              //       controller.userCommentImage.clear();
              //       controller.commentIdEditing.value = '';
              //     },
              //     child: Text(
              //       'Cancel',
              //       style: AppTextStyles.s14w600.copyWith(color: Colors.grey),
              //     ),
              //   ),
              //   title: Text(
              //     'You are editing a comment',
              //     style: AppTextStyles.s14w600.copyWith(color: Colors.grey),
              //   ),
              // ),
            ],
          ),
          _buildCommentTextEdit(),
        ],
      ),
    );
  }

  _buildCommentTextEdit() {
    return TextField(
      controller: controller.commentTextController,
      focusNode: controller.commentFocusNode,
      maxLines: null,
      textAlign: TextAlign.start,
      maxLength: 1000,
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      style: AppTextStyles.s14w400.copyWith(color: Colors.white),
      decoration: InputDecoration(
        suffix: ScaleButton(
          onTap: () => controller.onSubmit(),
          child: SvgPicture.asset(
            SvgPath.icSend,
          ),
        ),
        counterText: '',
        hintText: 'Add a comment',
        hintStyle: AppTextStyles.s14w600.copyWith(color: Colors.grey),
        border: InputBorder.none,
      ),
    );
  }

  _buildImagePreview() {
    return Obx(() => Visibility(
          visible: controller.userCommentImage.isNotEmpty,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: Get.width * 0.4,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: controller.userCommentImage.asMap().entries.map((e) {
                final index = e.key;
                final image = File(e.value.path);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: PostImageView(
                    image: FileImage(image),
                    removeElevation: (
                      showRemoveButton: true,
                      onTapRemove: () {
                        controller.onRemoveImage(index);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ));
  }
}
