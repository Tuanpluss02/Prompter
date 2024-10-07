import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/presentation/widgets/animated_scale_button.dart';
import 'package:flutter_svg/svg.dart';

/// A reusable button widget enriched with customization options for a tailored look and feel.
///
/// This widget is designed to provide a visually appealing button with an integrated
/// scaling animation that subtly plays when the button is pressed. It's perfect
/// for adding interactive elements to your Flutter application with a touch of polish.
///
/// The button's appearance is highly flexible. You can adjust its dimensions with
/// the [width] and [height] parameters, control outer spacing using [margin],
/// manage inner padding through [padding], and give it a visual overhaul with [decoration]
/// using BoxDecoration. If no [decoration] is provided, the button defaults to a
/// cheerful yellow rounded rectangle with a 20-pixel corner radius.
///
/// The text displayed on the button is determined by the [text] parameter,
/// which is styled according to the provided [textStyle]. If no style is given,
/// the text gracefully adopts a default style defined by AppTextStyles.s16w700,
/// featuring a classic black (AppColors.black0D1017) color for a timeless aesthetic.
///
/// As a navigational aid, you can choose to include a right arrow icon at
/// the end of the button text by setting [isShowArrow] to true. This adds a
/// subtle visual cue that can enhance the user experience.
///
/// To handle button presses, provide your desired action logic to the
/// [onTap] callback function. This is where you connect the button to your
/// application's business logic.
///
/// Example Usage:
/// ```dart
/// AppButton(
///   text: 'Submit',
///   onTap: () {
///     // Handle button press here
///   },
/// )
/// ```
///
/// You can find further examples demonstrating the full range of customization options
/// within your project's codebase. Happy coding!
class AppButton extends StatelessWidget {
  /// The width of the button. If null, the button will expand horizontally to fit its child.
  final double? width;

  /// The height of the button. If null, the button will expand vertically to fit its child.
  final double? height;

  /// The outer margin of the button, controlling the space around it.
  final EdgeInsets? margin;

  /// The inner padding of the button, controlling the space between its content and edges.
  final EdgeInsets? padding;

  /// The BoxDecoration applied to the background of the button, providing full control over its visual appearance.
  final BoxDecoration? decoration;

  /// The text displayed on the button, serving as the primary call to action.
  final String text;

  /// The TextStyle applied to the button text, dictating font properties like size, weight, and color.
  final TextStyle? textStyle;

  /// The callback function triggered when the button is pressed, executing the associated action.
  final Function() onTap;

  /// A boolean flag determining whether a right arrow icon is appended to the button text.
  final bool isShowArrow;

  /// Constructor for the [AppButton] widget. The [text] and [onTap] parameters are required.
  const AppButton({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.decoration,
    required this.text,
    required this.onTap,
    this.textStyle,
    this.isShowArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration:
            decoration ?? // Applies custom [decoration] if provided; otherwise defaults to a visually pleasing yellow rounded rectangle
                ShapeDecoration(
                  color: const Color(0xFFFFE500),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: textStyle ??
                  AppTextStyles.s16w700.copyWith(
                      color: AppColors
                          .black0D1017), // Employs provided [textStyle] or falls back to a well-defined default
            ),
            // Conditionally includes a Spacer and an arrow icon based on the value of [isShowArrow]
            if (isShowArrow) ...[
              const Spacer(),
              SvgPicture.asset(SvgPath.icArrowRight),
            ]
          ],
        ),
      ),
    );
  }
}
