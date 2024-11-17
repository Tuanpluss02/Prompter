import 'package:base/common/constants/app_color.dart';
import 'package:flutter/material.dart';

class AppLoadingIndicator extends StatelessWidget {
  const AppLoadingIndicator({super.key, this.value, this.color});
  final Color? color;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final progress = (value == null || value! < .05) ? null : value;

    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        color: color ?? AppColors.primaryColor,
        value: progress,
        strokeWidth: 1.0,
      ),
    );
  }
}
