import 'package:flutter/material.dart';
import 'package:base/app/constants/app_color.dart';

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  const CustomCheckbox(
      {super.key, this.isChecked = false, required this.onChanged});

  @override
  State<StatefulWidget> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  void _onTap() {
    setState(() {
      _isChecked = !_isChecked;
      widget.onChanged(_isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _isChecked ? AppColors.purple6B15A2 : AppColors.gray4B5563,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.white,
        ),
        width: 16,
        height: 16,
        child: _isChecked
            ? const Icon(
                Icons.check,
                color: AppColors.purple6B15A2,
                size: 12,
              )
            : null,
      ),
    );
  }
}
