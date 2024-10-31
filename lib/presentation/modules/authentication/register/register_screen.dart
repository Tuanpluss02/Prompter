import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/utils/validator.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forui/forui.dart';
import 'package:get/get.dart';

import 'register_controller.dart';

class RegisterScreen extends BaseScreen<RegisterController> {
  const RegisterScreen({super.key});
  @override
  Color? get screenBackgroundColor => Colors.black;

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: [
        Image.asset(ImagePath.logo, height: 300),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                FTextField.email(
                  hint: 'Enter your email',
                  controller: controller.emailController,
                  focusNode: controller.emailFocus,
                  validator: emailValidator,
                ),
                SizedBox(height: 16),
                FTextField.password(
                  hint: 'Enter your password',
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocus,
                  validator: passwordValidator,
                ),
                SizedBox(height: 16),
                FTextField.password(
                  hint: 'Confirm your password',
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocus,
                  validator: passwordValidator,
                ),
                GestureDetector(
                  onTap: controller.onSubmit,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: ShapeDecoration(
                      color: Color(0xFFB65FFC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: FDivider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(child: FDivider()),
                  ],
                ),
                SizedBox(height: 16),
                GestureDetector(
                  // onTap: controller.signInGoogle,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgPath.ic_Google,
                            height: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Continue with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.register),
                  child: HighlightedText(
                    text: 'Don\'t have an account? Register',
                    highlights: ['Register'],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
