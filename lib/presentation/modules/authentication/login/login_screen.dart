import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/data/local/app_storage.dart';
import 'package:base/presentation/modules/authentication/components/auth_submit_button.dart';
import 'package:base/presentation/modules/authentication/components/auth_textfield.dart';
import 'package:base/presentation/widgets/animated_tooltip.dart';
import 'package:base/presentation/widgets/animated_vertical_fade_switcher.dart';
import 'package:base/presentation/widgets/default_avatar.dart';
import 'package:base/presentation/widgets/flipcard/modal/flip_side.dart';
import 'package:base/presentation/widgets/flipcard/view/flip_card.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';
import 'package:base/presentation/widgets/shadowed_container.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_controller.dart';

class LoginScreen extends BaseScreen<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: controller.onPopInvoke,
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagePath.authBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Platform.isIOS ? 60 : 30),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildMainForm(),
                    _buildUserAvatar(),
                  ],
                ),
                const SizedBox(height: 38),
                _buildAdditionTextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildMainForm() {
    return ShadowedContainer(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.only(right: 24, left: 24, top: 58),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 47),
              _buildHeader(),
              _buildInput(),
              controller.errorText.value.isNotEmpty
                  ? _buildErrorText()
                  : const SizedBox(),
              const Spacer(),
              // controller.loginStep.value == LoginStep.enterPassword ?
              controller.loginStep.value == LoginStep.enterPassword &&
                      controller.errorCount.value.isLowerThan(5)
                  ? _buildForgotPasswordButton()
                  : const SizedBox.shrink()
              // : _buildOtherLoginMethod(),
            ],
          )),
    );
  }

  _buildAdditionTextButton() {
    return Obx(() {
      return controller.loginStep.value == LoginStep.enterPassword
          ? SizedBox(
              height: 18,
              child: AbsorbPointer(
                absorbing: controller.isSubmitting.value,
                child: GestureDetector(
                  onTap: controller.resetStateToLogin,
                  child: HighlightedText(
                    text:
                        '${tr(LocaleKeys.notYourAccount)} ${tr(LocaleKeys.changeAccount)}',
                    highlights: [tr(LocaleKeys.changeAccount)],
                    highlightStyle: GoogleFonts.manrope(
                      color: const Color(0xFF4F4950),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: const Color(0xFF4F4950),
                    ),
                    onTapHighlight: controller.resetStateToLogin,
                  ),
                ),
              ),
            )
          : const SizedBox.shrink();
    });
  }

  // _buildAdditionTextButton() {
  //   return Obx(
  //     () => SizedBox(
  //       height: 18,
  //       child: AbsorbPointer(
  //         absorbing: controller.isSubmitting.value,
  //         child: GestureDetector(
  //           onTap: controller.loginStep.value == LoginStep.enterPassword ? controller.resetStateToLogin : () {},
  //           child: HighlightedText(
  //             text: controller.loginStep.value == LoginStep.enterPassword ? '${tr(LocaleKeys.notYourAccount)} ${tr(LocaleKeys.changeAccount)}' : '${tr(LocaleKeys.wantToTry)} ${tr(LocaleKeys.visit)}',
  //             highlights: [controller.loginStep.value == LoginStep.enterPassword ? tr(LocaleKeys.changeAccount) : tr(LocaleKeys.visit)],
  //             highlightStyle: GoogleFonts.manrope(
  //               color: const Color(0xFF4F4950),
  //               fontSize: 14,
  //               fontWeight: FontWeight.w700,
  //               decoration: TextDecoration.underline,
  //               decorationColor: const Color(0xFF4F4950),
  //             ),
  //             onTapHighlight: controller.loginStep.value == LoginStep.enterPassword ? controller.resetStateToLogin : () {},
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  _buildErrorText() {
    return SizedBox(
      height: 36,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 170,
            child: Text(
              controller.errorText.value,
              maxLines: 2,
              style: const TextStyle(
                color: Color(0xFFE20003),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Visibility(
            visible: controller.errorText.value.isNotEmpty &&
                [2, 3, 4].contains(controller.errorCount.value),
            child: GestureDetector(
              child: AnimatedTooltip(
                content: HighlightedText(
                  text: 'Tài khoản sẽ tự động\nkhóa sau 5 lần nhập sai',
                  highlights: const ['5 lần'],
                  normalTextStyle: GoogleFonts.manrope(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  highlightStyle: GoogleFonts.manrope(
                    color: const Color(0xFFE00104),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                position: TooltipPosition.bottom,
                child: SvgPicture.asset(
                  SvgPath.icAttention,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildInput() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: AuthTextField(
              maxLength:
                  controller.loginStep.value == LoginStep.enterPhoneOrEmail
                      ? controller.loginMethod.value == LoginMethod.phone
                          ? 10
                          : null
                      : null,
              keyboardType:
                  controller.loginStep.value == LoginStep.enterPassword
                      ? TextInputType.visiblePassword
                      : (controller.loginMethod.value == LoginMethod.phone
                          ? TextInputType.phone
                          : TextInputType.emailAddress),
              focusNode: controller.textInputFocusNode,
              onSubmitted: controller.submit,
              controller: controller.textInputController,
              isPassword: controller.loginStep.value == LoginStep.enterPassword,
              obscureText:
                  controller.loginStep.value == LoginStep.enterPassword &&
                      !controller.isShowPassword.value,
              togglePassword: controller.toggleShowPassword,
              hintText: tr(LocaleKeys.enterField, namedArgs: {
                'field': controller.loginStep.value == LoginStep.enterPassword
                    ? tr(LocaleKeys.password).toLowerCase()
                    : (controller.loginMethod.value == LoginMethod.phone
                        ? tr(LocaleKeys.phoneNumber).toLowerCase()
                        : tr(LocaleKeys.email).toLowerCase())
              }),
            )),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 150),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    axis: Axis.horizontal,
                    sizeFactor: animation,
                    child: child,
                  ),
                );
              },
              child: controller.isShowSubmitButton.value
                  ? _buildSubmitButton()
                  : const SizedBox(),
            ),
            if (controller.loginStep.value == LoginStep.enterPassword &&
                AppStorage.getBool(SharedPreferencesKeys.isAuthBiometrics) ==
                    true)
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                    color: AppColors.grayF7F7F8,
                    borderRadius: BorderRadius.circular(20)),
                child: SvgPicture.asset(SvgPath.icFaceId),
              )
          ],
        ));
  }

  _buildSubmitButton() {
    return Obx(() => AuthSubmitButton(
          onTap: controller.submit,
          width: 56,
          height: 56,
          isLoading: controller.isSubmitting.value,
          isEnable: !controller.isSubmitting.value,
        ));
  }

  _buildForgotPasswordButton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: GestureDetector(
          onTap: controller.goToForgotPassword,
          child: Text(
            tr(LocaleKeys.forgotPassword),
            style: AppTextStyles.s14w700,
          )),
    );
  }

  // _buildOtherLoginMethod() {
  //   return Obx(() => Container(
  //         margin: const EdgeInsets.only(bottom: 40),
  //         child: AbsorbPointer(
  //           absorbing: controller.isSubmitting.value,
  //           child: GestureDetector(
  //             onTap: controller.toggleLoginMethod,
  //             child: Text(tr(LocaleKeys.useField, namedArgs: {'field': controller.loginMethod.value == LoginMethod.phone ? tr(LocaleKeys.email) : tr(LocaleKeys.phoneNumber).toLowerCase()}),
  //                 style: AppTextStyles.s14w700.copyWith(
  //                   color: AppColors.purple7527A4,
  //                 )),
  //           ),
  //         ),
  //       ));
  // }

  _buildHeader() {
    return Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedVerticalFadeSwitcher(
              firstChild: Align(
                key: const ValueKey(LocaleKeys.start),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 34,
                  child: Text(tr(LocaleKeys.start),
                      style: AppTextStyles.s28w600.copyWith(
                        color: AppColors.black0D1017,
                      )),
                ),
              ),
              secondChild: Align(
                key: const ValueKey(LocaleKeys.hi),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 34,
                  child: Hero(
                    tag: controller.appProvider.user.value.fullName!,
                    child: AutoSizeText(
                        '${tr(LocaleKeys.hi)} ${controller.appProvider.user.value.fullName!}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        minFontSize: 18,
                        style: AppTextStyles.s28w600.copyWith(
                          color: AppColors.black0D1017,
                        )),
                  ),
                ),
              ),
              isSecondChild:
                  controller.loginStep.value == LoginStep.enterPassword,
            ),
            const SizedBox(height: 8),
            HighlightedText(
              text: controller.loginStep.value == LoginStep.enterPassword
                  ? tr(LocaleKeys.enterYourFieldToLogin, namedArgs: {
                      'field': tr(LocaleKeys.password).toLowerCase()
                    })
                  : tr(LocaleKeys.enterYourFieldToContinue, namedArgs: {
                      'field': controller.loginMethod.value == LoginMethod.phone
                          ? tr(LocaleKeys.phoneNumber).toLowerCase()
                          : tr(LocaleKeys.email).toLowerCase()
                    }),
              highlights: [
                controller.loginStep.value == LoginStep.enterPassword
                    ? tr(LocaleKeys.password)
                    : controller.loginMethod.value == LoginMethod.phone
                        ? tr(LocaleKeys.phoneNumber).toLowerCase()
                        : tr(LocaleKeys.email).toLowerCase()
              ],
            ),
          ],
        ));
  }

  Widget _buildUserAvatar() {
    const avatarSize = 64.0;

    return Container(
      margin: const EdgeInsets.only(top: 16, left: 48),
      child: FlipCard(
        controller: controller.flipCardController,
        rotateSide: RotateSide.left,
        frontWidget: const Hero(tag: 'default_avatar', child: DefaultAvatar()),
        backWidget: SizedBox(
          width: avatarSize,
          height: avatarSize + 4,
          child: Center(
            child: Obx(
              () => Hero(
                tag: '${controller.appProvider.user.value.fullName}avatar',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(avatarSize / 2),
                  child: Image.network(
                    controller.appProvider.user.value.avatar!,
                    width: avatarSize,
                    height: avatarSize,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const DefaultAvatar(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
