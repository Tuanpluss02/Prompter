import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';

class CustomCard extends StatelessWidget {
  final String label;
  final Widget rightWidget;
  final IconData? leftIcon;
  final VoidCallback? onPressed;
  final String labelCustom;

  const CustomCard({
    super.key,
    required this.label,
    required this.rightWidget,
    this.leftIcon,
    this.onPressed,
    this.labelCustom = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Row(
            children: [
              Expanded(
                  child: Row(
                children: [
                  if (leftIcon != null) Icon(leftIcon, color: Colors.black),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(
                      color: AppColors.black0D1017,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  labelCustom != ''
                      ? Text(
                          labelCustom,
                          style: const TextStyle(
                            color: AppColors.blue5232D4,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Container(),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: rightWidget,
              )
            ],
          ),
        ),
      ),
    );
  }
}
