import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/constants/app_text_styles.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StepItemWidget extends StatelessWidget {
  const StepItemWidget({
    super.key,
    required this.step,
    required this.title,
    required this.icon,
    required this.isCompleted,
  });

  final int step;
  final String title;
  final Widget icon;
  final bool isCompleted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr(LocaleKeys.step, namedArgs: {'count': step.toString()}),
                    style: AppTextStyles.s16w700.copyWith(
                        color: isCompleted
                            ? AppColors.green26BF56
                            : AppColors.purple6D15A2),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: AppTextStyles.s16w700
                        .copyWith(color: AppColors.black1C2128),
                  ),
                ],
              ),
            ),
            if (isCompleted)
              SvgPicture.asset(
                SvgPath.icCheck,
                width: 29,
                height: 29,
              )
          ],
        ),
        const SizedBox(height: 12),
        if (!isCompleted) icon,
      ],
    );
  }
}
