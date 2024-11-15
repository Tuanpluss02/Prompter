import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value); // Toggle value when tapped
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 24,
        decoration: BoxDecoration(
          color: widget.value ? AppColors.yellowFFE500 : AppColors.black0D1017,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 10,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.value ? AppColors.black14081C : AppColors.gray93889A,
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: widget.value ? Alignment.centerLeft : Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  widget.value ? 'ON' : 'OFF',
                  style: TextStyle(
                    color: widget.value ? AppColors.black14081C : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
