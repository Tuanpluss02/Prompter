import 'package:base/presentation/widgets/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackButton extends StatelessWidget {
  final double? width;

  final double? height;

  final EdgeInsetsGeometry? margin;

  final Function()? onTap;

  const AppBackButton({
    super.key,
    this.width = 50,
    this.height = 50,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: onTap ?? () => Get.back(),
      child: Container(
        width: width,
        height: height,
        margin: margin ?? const EdgeInsets.only(top: 16, left: 16),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 3,
              offset: const Offset(5, 10),
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
