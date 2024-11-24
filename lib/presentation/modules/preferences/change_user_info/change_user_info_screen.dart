import 'dart:io';

import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/validator.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/account/lib/delete_account.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/chat_view/src/extensions/extensions.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:base/presentation/shared/global/app_text_field.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'change_user_info_controller.dart';

class ChangeUserInfoScreen extends BaseScreen<ChangeUserInfoController> {
  const ChangeUserInfoScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(margin: EdgeInsets.zero),
              SizedBox(height: 48),
              Text(
                'Change Your\nInformation',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: controller.onPickImage,
                  child: Stack(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        child: Obx(() => ClipOval(
                                child: Image(
                              image: controller.avatar.value.isImageUrl ? ExtendedNetworkImageProvider(controller.avatar.value) : FileImage(File(controller.avatar.value)),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => SvgPicture.asset(SvgPath.icPersonFilled),
                            ))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: controller.displayNameController,
                focusNode: controller.displayNameFocus,
                validator: fullNameValidator,
                hintText: 'Display Name',
                textInputAction: TextInputAction.next,
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              AppTextField(
                controller: controller.usernameController,
                focusNode: controller.usernameFocus,
                validator: usernameValidator,
                hintText: 'Username',
                textInputAction: TextInputAction.done,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '@',
                    style: GoogleFonts.manrope(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildRemoveAccountButton(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  _buildRemoveAccountButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ScaleButton(
        onTap: () {
          showDialog(
            context: Get.context!,
            barrierColor: Colors.transparent,
            builder: (_) {
              return const AlertDialog(
                backgroundColor: Colors.transparent,
                content: Wrap(
                  children: [
                    DeleteAccount(),
                  ],
                ),
              );
            },
          );
        },
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgPath.icTrashbin,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
              ),
              SizedBox(width: 8),
              Text('Delete Account',
                  style: AppTextStyles.s16w800.copyWith(
                    color: Colors.red,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  ScaleButton _buildSubmitButton() {
    return ScaleButton(
      onTap: controller.onSubmit,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0XFF0677e8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            'Save',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
