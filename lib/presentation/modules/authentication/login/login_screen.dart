import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/utils/validator.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/widgets/animated/animated_scale_button.dart';
import 'package:base/presentation/widgets/global/app_back_button.dart';
import 'package:base/presentation/widgets/global/app_text_field.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_controller.dart';

class LoginScreen extends BaseScreen<LoginController> {
  const LoginScreen({super.key});

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
                'Login Your\nAccount',
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              AppTextField(
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                validator: emailValidator,
                hintText: 'Enter Your Email',
                textInputAction: TextInputAction.next,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Obx(() => AppTextField(
                    controller: controller.passwordController,
                    hintText: 'Password',
                    validator: passwordValidator,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
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
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.manrope(
                      color: Color(0XFFacadb9),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
              'Login',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ))),
        onTap: controller.onSubmit);
  }

  Center _buildSignInText() {
    return Center(
      child: HighlightedText(
        text: 'Don\'t have an account? Sign Up',
        highlights: ['Sign Up'],
        onTapHighlight: () => Get.toNamed(AppRoutes.register),
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
      onTap: controller.signInGoogle,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0XFF0f2e53),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                SvgPath.ic_google,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 8),
              Text(
                'Continue with Google',
                style: GoogleFonts.poppins(
                  color: Color(0xff0677e8),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
