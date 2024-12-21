import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  final double? size;

  final EdgeInsetsGeometry? margin;

  final Function()? onTap;

  const AppBackButton({
    super.key,
    this.size = 50,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap ?? () => Get.back(),
      child: Container(
        width: size,
        height: size,
        margin: margin ?? const EdgeInsets.only(top: 16, left: 16),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.2),
              blurRadius: 20,
              spreadRadius: 1,
              offset: const Offset(10, 10),
            ),
          ],
        ),
        child: Icon(
          color: Colors.black,
          Icons.arrow_back_ios,
        ),
      ),
    );
  }
}
