import 'package:base/app/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.type = ButtonType.primary,
    required this.text,
    this.onTap,
    this.textStyle,
    this.height,
    this.width,
    this.padding,
    this.margin,
  });

  final ButtonType type;
  final String text;
  final Function()? onTap;
  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: type == ButtonType.primary ? Color(0XFF0677e8) : Color(0XFF0f2e53),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? AppTextStyles.s16w700,
          ),
        ),
      ),
    );
  }
}
