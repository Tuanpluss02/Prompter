import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:base/base/base_screen.dart';
import 'package:base/data/models/page_data/Register_page_data.dart';
import 'package:base/presentation/modules/authentication/components/auth_submit_button.dart';
import 'package:base/presentation/modules/authentication/components/auth_textfield.dart';
import 'package:base/presentation/modules/authentication/register/register_controller.dart';
import 'package:base/presentation/modules/authentication/register/widget/register_tooltip.dart';
import 'package:base/presentation/widgets/animated_tooltip.dart';
import 'package:base/presentation/widgets/highlighted_text.dart';
import 'package:base/presentation/widgets/shadowed_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends BaseScreen<RegisterController> {
  const RegisterPage({super.key});

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
            child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: controller.step.value == RegisterStep.enterOtp
                ? _enterOtp()
                : controller.step.value == RegisterStep.createName
                    ? _createName()
                    : _createPassword(),
          ),
        )),
      ),
    );
  }

  _enterOtp() {
    return <Widget>[
      SizedBox(height: Platform.isIOS ? 60 : 30),
      Stack(
          clipBehavior: Clip.none,
          children: [_buildMainFormOtp(), _buildUserAvatar()]),
      const SizedBox(height: 38),
      _buildAdditionTextButton(),
    ];
  }

  _createName() {
    return [
      SizedBox(height: Platform.isIOS ? 60 : 30),
      Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: double.infinity,
            height: Get.height * 0.2,
            child: Lottie.asset(LottiePath.confetti,
                fit: BoxFit.cover, repeat: false),
          ),
          _buildMainFormName(),
          _buildUserAvatar(),
          _buildBackHome(),
        ],
      )
    ];
  }

  _createPassword() {
    return <Widget>[
      SizedBox(height: Platform.isIOS ? 60 : 30),
      Stack(
        clipBehavior: Clip.none,
        children: [
          _buildMainFormPassword(),
          _buildUserAvatar(),
          _buildBackHome(),
        ],
      )
    ];
  }

  _buildMainFormPassword() {
    return Padding(
      padding: const EdgeInsets.only(right: 48, left: 48, top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '👋',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(width: 10),
          Text(
            tr(LocaleKeys.createAPasswordLogIn),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          HighlightedText(
            text: tr(LocaleKeys.createALoginPasswordForYourNextAccess),
            highlights: [tr(LocaleKeys.loginPassword)],
            normalTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 26),
          _buildInputPassword()
        ],
      ),
    );
  }

  _buildMainFormName() {
    return Padding(
      padding: const EdgeInsets.only(right: 48, left: 48, top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '👋',
            style: TextStyle(fontSize: 40),
          ),
          const SizedBox(width: 10),
          Text(
            tr(LocaleKeys.welcomeToF1Trading),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          HighlightedText(
            text: tr(LocaleKeys.updateYourAccountInformationAndStartF1Trading),
            highlights: const ['F1 Trading'],
            normalTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 26),
          _buildInputName()
        ],
      ),
    );
  }

  _buildMainFormOtp() {
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
            _buildInputOtp(),
            const Spacer(),
            controller.step.value != RegisterStep.enterOtp ||
                    !controller.isEnableResendOtp.value
                ? const SizedBox.shrink()
                : controller.isShowTimerButton.value
                    ? _buildTextResendOpt()
                    : _buildTextResendOtpTimer(),
          ],
        ),
      ),
    );
  }

  _buildAdditionTextButton() {
    return SizedBox(
      height: 18,
      child: GestureDetector(
        onTap: controller.onBackpress,
        child: HighlightedText(
          text: '${tr(LocaleKeys.wantToUseAnotherField, namedArgs: {
                'field': RegisterPageType.email.value == controller.type.value
                    ? tr(LocaleKeys.email)
                    : tr(LocaleKeys.phoneNumber).toLowerCase()
              })} ${tr(LocaleKeys.changeAccount)}',
          highlights: [tr(LocaleKeys.changeAccount)],
          highlightStyle: GoogleFonts.manrope(
            color: const Color(0xFF4F4950),
            fontSize: 14,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationColor: const Color(0xFF4F4950),
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 16, left: 48),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 64,
              width: 64,
              padding: const EdgeInsets.fromLTRB(8, 21, 14, 21.63),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.step.value != RegisterStep.enterOtp
                    ? AppColors.yellowFFDC00
                    : Colors.black,
              ),
              child: controller.step.value != RegisterStep.enterOtp
                  ? RotationTransition(
                      turns: const AlwaysStoppedAnimation(1),
                      child: SvgPicture.asset(
                        SvgPath.icF1Logo,
                        colorFilter: const ColorFilter.mode(
                            AppColors.purple6D15A2, BlendMode.srcIn),
                      ),
                    )
                  : SvgPicture.asset(
                      SvgPath.icF1Logo,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackHome() {
    return Align(
      alignment: Alignment.topRight, // Align to the top-right corner
      child: Container(
        margin: const EdgeInsets.only(top: 10, right: 30),
        child: GestureDetector(
          onTap: controller.onBackpress,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(19, 5, 10, 21.63),
                child: SvgPicture.asset(
                  SvgPath.icBackHome,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTextResendOtpTimer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Obx(
        () => Text(
            '${controller.resendOtpTime.value} ${tr(LocaleKeys.seconds)}',
            style: AppTextStyles.s14w700),
      ),
    );
  }

  _buildTextResendOpt() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 40),
        child: controller.isSendingOtp.value
            ? Text(LocaleKeys.sending, style: AppTextStyles.s14w700).tr()
            : GestureDetector(
                onTap: controller.resendOtp,
                child: Text(LocaleKeys.resendOtp, style: AppTextStyles.s14w700)
                    .tr(),
              ),
      ),
    );
  }

  _buildInputName() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildTextFieldName(),
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
            child: controller.isShowBtnSubmitName.value
                ? _buildSubmitButtonName()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  _buildInputPassword() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTextFieldPassword(),
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
                child: controller.isShowBtnSubmitPassword.value
                    ? _buildSubmitButtonPassword()
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          if (controller.step.value == RegisterStep.createPassword) ...[
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
          ]
        ],
      ),
    );
  }

  _buildInputOtp() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildTextFieldOpt(),
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
                ? _buildSubmitButtonOtp()
                : const SizedBox.shrink(),
          ),
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

  _buildTextFieldName() {
    return Obx(() {
      return Column(
        children: [
          // The actual text field
          AuthTextField(
            keyboardType: TextInputType.text,
            focusNode: controller.textInputFocusNode,
            controller: controller.inputController,
            onSubmitted: controller.onBtnAuthSubmited,
            isPassword: false,
            obscureText: false,
            togglePassword: null,
            hintText: tr(LocaleKeys.fullName),
          ),
          // Tooltip positioned above the text field
          controller.showTooltip.value
              ? const RegisterTooltip()
              : Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    _buildErrortext(errorText: controller.nameErrorText.value)
                  ],
                ),
        ],
      );
    });
  }

  _buildTextFieldPassword() {
    return Obx(
      () => AuthTextField(
        keyboardType: TextInputType.visiblePassword,
        focusNode: controller.textInputFocusNode,
        controller: controller.inputController,
        onSubmitted: controller.onBtnAuthSubmited,
        isPassword: controller.step.value == RegisterStep.createPassword,
        obscureText: !controller.isShowPassword.value,
        togglePassword: controller.toggleShowPassword,
        hintText: tr(LocaleKeys.password),
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

  _buildSubmitButtonOtp() {
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

  _buildSubmitButtonName() {
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

  _buildSubmitButtonPassword() {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr(LocaleKeys.enterTheVerificationCode),
            style: AppTextStyles.s28w600.copyWith(
              color: AppColors.black0D1017,
            )),
        const SizedBox(height: 8),
        HighlightedText(
          text: _textBodyRegister(),
          highlights: [_textBodyHightLightRegister()],
        ),
      ],
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

  String _textBodyRegister() {
    String body = '';
    body = tr(LocaleKeys.verifyYourAccountAndStartYourExplorationNowF1Trading);
    return body;
  }

  String _textBodyHightLightRegister() {
    return 'F1 Trading';
  }
}
