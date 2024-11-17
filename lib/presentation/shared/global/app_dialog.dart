import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/shared/global/app_button.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryButtonTap,
    required this.onSecondaryButtonTap,
  });

  final String title;
  final String content;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryButtonTap;
  final VoidCallback onSecondaryButtonTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.dialogBackgroundColor,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              content,
              textAlign: TextAlign.center,
              style: AppTextStyles.s14w400,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    type: ButtonType.secondary,
                    text: secondaryButtonText,
                    height: 50,
                    onTap: onSecondaryButtonTap,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    type: ButtonType.primary,
                    text: primaryButtonText,
                    height: 50,
                    onTap: onPrimaryButtonTap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
