import 'package:base/app/constants/app_color.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/widgets/animated_scale_button.dart';
import 'package:base/presentation/widgets/app_back_button.dart';
import 'package:base/presentation/widgets/app_text_field.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'register_controller.dart';

class RegisterScreen extends BaseScreen<RegisterController> {
  const RegisterScreen({super.key});
  @override
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(
              margin: EdgeInsets.zero,
            ),
            SizedBox(height: 48),
            Text(
              'Create Your\nAccount',
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
              hintText: 'Full Name',
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: 16),
            AppTextField(
              controller: controller.emailController,
              focusNode: controller.emailFocus,
              hintText: 'Enter Your Email',
              textInputAction: TextInputAction.next,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            AppTextField(
              controller: controller.passwordController,
              focusNode: controller.passwordFocus,
              hintText: 'Password',
              textInputAction: TextInputAction.done,
              prefixIcon: Icon(
                Icons.password_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            _buildSubmitButton(),
            SizedBox(height: 12),
            _buildSignInText(),
            _buildDivider(),
            SizedBox(height: 16),
            _buildContinueGoogle()
          ],
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
              'Register',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ))),
        onTap: () {});
  }

  Center _buildSignInText() {
    return Center(
      child: HighlightedText(
        text: 'Already Have An Account? Sign In',
        highlights: ['Sign In'],
        onTapHighlight: () => Get.back(),
        highlightStyle: GoogleFonts.manrope(
          color: Color(0xFF0677e8),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        normalTextStyle: GoogleFonts.manrope(
          color: Color(0XFFacadb9),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ScaleButton _buildContinueGoogle() {
    return ScaleButton(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0XFF0f2e53),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            'Continue with Google',
            style: GoogleFonts.poppins(
              color: Color(0xff0677e8),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Row _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: Color(0XFFacadb9),
          ),
        ),
        SizedBox(width: 8),
        Text(
          'Or',
          style: GoogleFonts.manrope(
            color: Color(0XFFacadb9),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Divider(
            color: Color(0XFFacadb9),
            thickness: 1,
            height: 40,
          ),
        ),
      ],
    );
  }
}
