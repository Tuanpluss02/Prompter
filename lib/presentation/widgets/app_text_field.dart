import 'package:base/app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.validator,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.readOnly,
    this.enabled,
    this.prefixIcon,
  });

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final String? Function(String?)? validator;

  final String? hintText;

  final Widget? prefixIcon;

  final TextInputType? keyboardType;

  final TextInputAction? textInputAction;

  final bool? obscureText;

  final bool? readOnly;

  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      enabled: enabled ?? true,
      style: GoogleFonts.manrope(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        // suffixIcon: ,
        fillColor: AppColors.textFieldColor,
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.manrope(
          color: Colors.white,
          fontSize: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldBorderColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldBorderErrorColor, width: 2),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFieldBorderErrorColor, width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
