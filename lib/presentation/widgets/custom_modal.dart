import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';

class CustomModal extends StatelessWidget {
  final String title;
  final String message;
  final String? confirmText;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomModal({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
    this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.s16w700.copyWith(color: AppColors.black14081C),
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: onCancel),
            ],
          ),
          Text(
            message,
            style: AppTextStyles.s14w500.copyWith(color: AppColors.gray61646B),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onCancel,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.grayD1D5DB),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      tr(LocaleKeys.cancel),
                      style: AppTextStyles.s15w600.copyWith(
                        color: AppColors.black0D1017,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: onConfirm,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.yellowFFDC00,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    child: Text(
                      confirmText ?? tr(LocaleKeys.confirmRegister),
                      style: AppTextStyles.s15w600.copyWith(
                        color: AppColors.black0D1017,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
