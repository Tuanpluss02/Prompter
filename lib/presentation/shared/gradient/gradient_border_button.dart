import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientBorderButton extends StatelessWidget {
  final String text;
  final String icon;
  final VoidCallback onPressed;

  const GradientBorderButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(1), // Padding for the gradient border
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.purpleA410FA, AppColors.yellowFFDC00], // Gradient border colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30), // Rounded border radius
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.yellowFFFDF0, // Background color
            borderRadius: BorderRadius.circular(30), // Same radius as outer border
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.black, // Icon background color
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  icon, // Icon data passed from the constructor
                  width: 16,
                  height: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                text, // Text passed from the constructor
                style: AppTextStyles.s14w600.copyWith(
                  color: AppColors.black272A31,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
