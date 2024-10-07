import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/app/utils/log.dart';
import 'package:base/app/utils/obscure.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/data/models/page_data/forgot_page_data.dart';
import 'package:base/presentation/modules/authentication/components/auth_submit_button.dart';
import 'package:base/presentation/modules/authentication/components/auth_textfield.dart';
import 'package:base/presentation/modules/authentication/forgot/forgot_controller.dart';
import 'package:base/presentation/widgets/animated_tooltip.dart';
import 'package:base/presentation/widgets/animated_vertical_fade_switcher.dart';
import 'package:base/presentation/widgets/default_avatar.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';
import 'package:base/presentation/widgets/shadowed_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotScreen extends BaseScreen<ForgotController> {
  const ForgotScreen({super.key});

  @override
  Widget buildScreen(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {},
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
    );
  }

  _buildMainForm() {
    return ShadowedContainer(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.only(right: 24, left: 24, top: 58),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 47),
            _buildHeader(),
            _buildInput(),
            const Spacer(),
            controller.step.value == ForgotStep.resetPassword ||
                    !controller.isEnableResendOtp.value
                ? const SizedBox.shrink()
                : controller.isShowTimerButton.value
                    ? _buildTextResendOptButton()
                    : _buildTextResendOtpTimer(),
          ],
        ),
      ),
    );
  }

  _buildUserAvatar() {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 48),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          controller.avatarLink.isNotEmpty
              ? Container(
                  width: 64,
                  height: 64,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                  child: Image.network(
                    controller.avatarLink,
                    errorBuilder: (context, error, stackTrace) =>
                        const DefaultAvatar(),
                  ),
                )
              : const DefaultAvatar(),
          Positioned(
            left: 28,
            top: 60,
            child: Container(
              width: 8,
              height: 8,
              decoration: const ShapeDecoration(
                color: Color(0xFF1AD822),
                shape: OvalBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildAdditionTextButton() {
    return GestureDetector(
      onTap: controller.onBackpress,
      child: HighlightedText(
        onTapHighlight: controller.onBackpress,
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
      ),
    );
  }

  _buildTextResendOtpTimer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Obx(
        () =>
            Text('${controller.resendOtpTime.value} ${tr(LocaleKeys.seconds)}',
                style: AppTextStyles.s14w700.copyWith(
                  color: Colors.black,
                )),
      ),
    );
  }

  _buildTextResendOptButton() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: controller.isSendingOtp.value
            ? Text(LocaleKeys.sending,
                style: AppTextStyles.s14w700.copyWith(
                  color: Colors.black,
                )).tr()
            : GestureDetector(
                onTap: controller.resendOtp,
                child: Text(LocaleKeys.resendOtp,
                    style: AppTextStyles.s14w700.copyWith(
                      color: Colors.black,
                    )).tr(),
              ),
      ),
    );
  }

  _buildInput() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: controller.step.value == ForgotStep.enterOtp
                    ? _buildTextFieldOpt()
                    : _buildTextFiledCreatePassword(),
              ),
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
                child: controller.isShowBtnSubmit.value
                    ? _buildSubmitButton()
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          if (controller.step.value == ForgotStep.resetPassword) ...[
            const SizedBox(height: 12),
            _buildValidatePasswordRow(
              title: tr(LocaleKeys.hasSpecialCharacter),
              isValid: controller.isHasSpecialCharacter.value,
            ),
            const SizedBox(height: 8),
            _buildValidatePasswordRow(
              title: tr(LocaleKeys.hasUpperCaseAndLowerCaseAndDigit),
              isValid: controller.isHasUpperAndLowerCaseAndDigit.value,
            ),
            const SizedBox(height: 8),
            _buildValidatePasswordRow(
              title: tr(LocaleKeys.charactersLongOrMore,
                  namedArgs: {'length': '8'}),
              isValid: controller.isLengthValid.value,
            ),
          ],
        ],
      ),
    );
  }

  _buildTextFieldOpt() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AuthTextField(
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: false),
            focusNode: controller.textInputFocusNode,
            controller: controller.inputController,
            onSubmitted: controller.onBtnAuthSubmited,
            isPassword: false,
            obscureText: false,
            togglePassword: null,
            hintText: tr(LocaleKeys.enterOtp),
            maxLength: 6,
          ),
          _buildErrortext(
            errorText: controller.otpErrorText.value,
          ),
        ],
      ),
    );
  }

  _buildErrortext({String errorText = '', Widget? errorHelper}) {
    return errorText.isNotEmpty
        ? SizedBox(
            height: 40,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    errorText,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color(0xFFE20003),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (errorHelper != null) ...[
                  const SizedBox(width: 8),
                  GestureDetector(
                    child: AnimatedTooltip(
                      content: errorHelper,
                      position: TooltipPosition.bottom,
                      child: SvgPicture.asset(
                        SvgPath.icAttention,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  _buildTextFiledCreatePassword() {
    return Obx(
      () => AuthTextField(
        keyboardType: TextInputType.visiblePassword,
        focusNode: controller.textInputFocusNode,
        controller: controller.inputController,
        onSubmitted: controller.onBtnAuthSubmited,
        isPassword: controller.step.value == ForgotStep.resetPassword,
        obscureText: !controller.isShowPassword.value,
        togglePassword: controller.toggleShowPassword,
        hintText: tr(LocaleKeys.enterNewPassword),
      ),
    );
  }

  _buildValidatePasswordRow({
    required String title,
    required bool isValid,
  }) {
    return Row(
      children: [
        isValid
            ? SvgPicture.asset(
                SvgPath.icCheck,
                width: 16,
                height: 16,
              )
            : SvgPicture.asset(
                SvgPath.icDot,
                width: 16,
                height: 16,
              ),
        const SizedBox(width: 4),
        Text(
          title,
          style: AppTextStyles.s13w400.copyWith(
            color: isValid ? const Color(0xFF26BF56) : const Color(0xFF272A31),
          ),
        ),
      ],
    );
  }

  _buildSubmitButton() {
    return Obx(
      () => AuthSubmitButton(
        onTap: controller.onBtnAuthSubmited,
        width: 56,
        height: 56,
        isLoading: controller.loading.value,
        isEnable: !controller.loading.value,
      ),
    );
  }

  _buildHeader() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedVerticalFadeSwitcher(
            firstChild: Align(
              key: const ValueKey(LocaleKeys.forgotPassword),
              alignment: Alignment.centerLeft,
              child: Text(tr(LocaleKeys.forgotPassword),
                  style: AppTextStyles.s28w600.copyWith(
                    color: AppColors.black0D1017,
                  )),
            ),
            secondChild: Align(
              key: const ValueKey(LocaleKeys.createNewPassword),
              alignment: Alignment.centerLeft,
              child: Text(LocaleKeys.createNewPassword,
                  style: AppTextStyles.s28w600.copyWith(
                    color: AppColors.black0D1017,
                  )).tr(),
            ),
            isSecondChild: controller.step.value == ForgotStep.resetPassword,
          ),
          const SizedBox(height: 8),
          HighlightedText(
            text: _textBodyForgot(),
            highlights: [_textBodyHightLightForgot()],
          ),
        ],
      ),
    );
  }

  String _textBodyForgot() {
    String body = '';
    if (controller.step.value == ForgotStep.resetPassword) {
      body = tr(LocaleKeys
          .enterYourNewPasswordAndContinueYourGreatExperienceAtF1Trading);
      return body;
    }
    if (controller.type == ForgotPageType.phone) {
      Log.console('phone: ${controller.phoneNumber}');
      body = tr(LocaleKeys.dontWorryEnterOtpSentToPhone,
          namedArgs: {'phone': obscurePhoneNumber(controller.phoneNumber!)});
    } else {
      body = tr(LocaleKeys.dontWorryEnterOtpSentToEmail,
          namedArgs: {'email': obscureEmail(controller.email!)});
    }
    return body;
  }

  String _textBodyHightLightForgot() {
    if (controller.step.value == ForgotStep.resetPassword) {
      return 'F1 Trading';
    }
    if (controller.type == ForgotPageType.phone) {
      return obscurePhoneNumber(controller.phoneNumber!);
    }
    return obscureEmail(controller.email!);
  }
}
