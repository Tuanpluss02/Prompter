import 'dart:io';

import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/post_image_view.dart';
import 'package:base/presentation/modules/home/components/post_input_action.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:base/presentation/shared/global/app_button.dart';
import 'package:flutter/material.dart';
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
              user: controller.appProvider.user.value,
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
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: PostImageView(
                  image: FileImage(File(controller.postImages.first.path)),
                  removeElevation: (
                    showRemoveButton: true,
                    onTapRemove: () {
                      controller.onRemoveImage(0);
                    },
                  ),
                ),
              )
            : ListView(
                scrollDirection: Axis.horizontal,
                children: controller.postImages.asMap().entries.map((e) {
                  final index = e.key;
                  final image = File(e.value.path);
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
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
    );
  }

  _buildPostInputOption() {
    return Padding(
      padding: const EdgeInsets.only(left: 90),
      child: PostInputAction(
        onTapImage: controller.onSelectImage,
        onTapLink: () {},
        onTapMention: () {},
        onTapHastag: () {},
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
        child: TextField(
          focusNode: controller.textFocus,
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
        ));
  }
}
