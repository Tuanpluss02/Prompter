import 'package:base/app/constants/app_color.dart';
import 'package:base/app/utils/validator.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/widgets/animated/animated_scale_button.dart';
import 'package:base/presentation/widgets/global/app_back_button.dart';
import 'package:base/presentation/widgets/global/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'reset_password_controller.dart';

class ResetPasswordScreen extends BaseScreen<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

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
                'Reset Your\nPassword',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Obx(() => AppTextField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocus,
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
        child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0XFF0677e8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
                child: Text(
              'Reset Password',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ))),
        onTap: controller.onSubmit);
  }
}
