import 'package:base/common/constants/app_color.dart';
import 'package:base/common/utils/validator.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:base/presentation/shared/global/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'change_user_info_controller.dart';

class ChangeUserInfoScreen extends BaseScreen<ChangeUserInfoController> {
  const ChangeUserInfoScreen({super.key});

  @override
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @override
  bool get wrapWithSafeArea => true;

  @override
  bool get resizeToAvoidBottomInset => true;

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
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: controller.fullNameController,
                focusNode: controller.fullNameFocus,
                validator: fullNameValidator,
                hintText: 'Enter Your Full Name',
                textInputAction: TextInputAction.next,
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              AppTextField(
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                validator: emailValidator,
                hintText: 'Enter Your Email',
                textInputAction: TextInputAction.done,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              _buildSubmitButton(),
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
            ))));
  }
}
