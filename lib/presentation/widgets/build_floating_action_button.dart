import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';

class GlobalFloatingActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const GlobalFloatingActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ClipOval(
        child: Material(
          color: AppColors.black14081C,
          elevation: 20,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: IconButton(
              icon: Image.asset(
                ImagePath.imgMission,
                height: 42,
                width: 42,
              ),
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
