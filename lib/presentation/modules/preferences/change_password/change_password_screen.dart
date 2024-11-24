import 'package:base/common/constants/app_color.dart';
import 'package:base/common/utils/validator.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_back_button.dart';
import 'package:base/presentation/shared/global/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'change_password_controller.dart';

class ChangePasswordScreen extends BaseScreen<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

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
              if (controller.isUserLoggedInWithGoogle())
                Column(
                  children: [
                    Text(
                      'You are logged in with Google. You cannot change your password.',
                      style: GoogleFonts.manrope(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              Text(
                'Change Your\nPassword',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Obx(() => AppTextField(
                    controller: controller.currentPasswordController,
                    focusNode: controller.currentPasswordFocus,
                    validator: passwordValidator,
                    hintText: 'Current Password',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.obscureText.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.white,
                      ),
                      onPressed: controller.toggleObscureText,
                    ),
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: Colors.white,
                    ),
                    enabled: !(controller.isUserLoggedInWithGoogle()),
                  )),
              SizedBox(height: 16),
              Obx(() => AppTextField(
                    controller: controller.newPasswordController,
                    focusNode: controller.newPasswordFocus,
                    validator: passwordValidator,
                    hintText: 'New Password',
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.obscureText.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.white,
                      ),
                      onPressed: controller.toggleObscureText,
                    ),
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: Colors.white,
                    ),
                    enabled: !(controller.isUserLoggedInWithGoogle()),
                  )),
              SizedBox(height: 16),
              Obx(() => AppTextField(
                    controller: controller.confirmPasswordController,
                    focusNode: controller.confirmPasswordFocus,
                    validator: passwordValidator,
                    hintText: 'Confirm Password',
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.obscureText.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.white,
                      ),
                      onPressed: controller.toggleObscureText,
                    ),
                    prefixIcon: Icon(
                      Icons.password_outlined,
                      color: Colors.white,
                    ),
                    enabled: !(controller.isUserLoggedInWithGoogle()),
                  )),
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
              'Change Password',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ))));
  }
}
