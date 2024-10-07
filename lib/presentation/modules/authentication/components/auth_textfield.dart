import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:flutter_svg/svg.dart';

/// A custom text field widget for authentication forms.
///
/// The `AuthTextField` widget provides a stylized text field with optional
/// features like password visibility toggle, error message display, and an error
/// helper tooltip.
///
/// It allows customization of properties such as `hintText`, `obscureText`,
/// `keyboardType`, and `textInputAction`. Additionally, it provides callbacks
/// for various events like `onChanged`, `onEditingComplete`, and `onSubmitted`.
class AuthTextField extends StatelessWidget {
  /// The hint text displayed when the text field is empty.
  final String hintText;

  /// The controller for the editable text field.
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// Called when the user initiates a change to the TextField's value.
  final ValueChanged<String>? onChanged;

  /// Called when the user has completed editing the text field.
  final VoidCallback? onEditingComplete;

  /// Called when the user indicates that they are done editing the text field.
  final VoidCallback? onSubmitted;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// The type of keyboard to use for editing the text field.
  final TextInputType? keyboardType;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool? obscureText;

  /// Whether the text field is used for password input.
  final bool? isPassword;

  /// Whether the text field is enabled or not.
  final bool? isEnable;

  /// Whether the text field should be automatically focused.
  final bool? autoFocus;

  /// An optional helper widget to display next to the error message.
  final Widget? errorHelper;

  /// A callback function to toggle the password visibility.
  final Function()? togglePassword;

  /// The error message to display below the text field.
  final String errorText;

  final int? maxLength;

  /// Creates a new `AuthTextField`.
  const AuthTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.textInputAction,
    this.keyboardType,
    this.autoFocus = false,
    this.obscureText = false,
    this.isPassword = false,
    this.isEnable = true,
    this.togglePassword,
    this.maxLength,
    this.errorText = '',
    this.errorHelper,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 23),
      enabled: isEnable ?? true,
      controller: controller,
      focusNode: focusNode,
      cursorErrorColor: Colors.black,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: (value) {
        onSubmitted?.call();
      },
      maxLength: maxLength,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      autofocus: autoFocus ?? false,
      obscureText: obscureText ?? false,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xFFC9CDD2),
            fontSize: 23,
            fontWeight: FontWeight.w500),
        border: InputBorder.none,
        suffixIcon: isPassword!
            ? IconButton(
                onPressed: togglePassword,
                icon: SvgPicture.asset(
                  obscureText!
                      ? SvgPath.icVisibilityOn
                      : SvgPath.icVisibilityOff,
                  fit: BoxFit.cover,
                ),
                iconSize: 30,
              )
            : const SizedBox(),
      ),
    );
  }
}
