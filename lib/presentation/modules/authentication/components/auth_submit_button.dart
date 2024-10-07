import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';

/// A stylized button widget typically used for authentication actions.
///
/// The `AuthSubmitButton` widget provides a visually appealing button with
/// a rounded rectangular shape and an optional loading indicator.
///
/// It allows customization of the button's `width`, `height`, and `color`.
/// The button can be enabled or disabled using the `isEnable` property, and
/// a loading indicator can be displayed by setting `isLoading` to true.
///
/// When the button is tapped and `isLoading` is false, the `onTap` callback
/// is triggered.
class AuthSubmitButton extends StatelessWidget {
  /// A callback function triggered when the button is tapped and enabled.
  final Function()? onTap;

  /// The width of the button.
  final double width;

  /// The height of the button.
  final double height;

  /// The background color of the button. Defaults to a yellow color.
  final Color? color;

  /// Whether the button is enabled or disabled.
  final bool? isEnable;

  /// Whether to display a loading indicator.
  final bool? isLoading;

  /// Creates a new `AuthSubmitButton`.
  const AuthSubmitButton(
      {super.key,
      this.onTap,
      required this.width,
      required this.height,
      this.color = const Color(0xFFFFE545),
      this.isEnable,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable! ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Center(
          child: isLoading!
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.black0D1017),
                      strokeWidth: 2),
                )
              : const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.black0D1017,
                  size: 25,
                ),
        ),
      ),
    );
  }
}
