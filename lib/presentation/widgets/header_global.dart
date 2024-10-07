import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:flutter_svg/svg.dart';

class HeaderGlobal extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? child;
  final Function()? onTapSearch;
  final bool isShowNotification;
  final bool isShowSearch;

  const HeaderGlobal({
    super.key,
    this.title,
    this.child,
    this.isShowNotification = true,
    this.isShowSearch = true,
    this.onTapSearch,
  }) : assert(child != null && title == null || child == null && title != null,
            'child and title must not be null at the same time');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: AppColors.transparent,
      backgroundColor: AppColors.appColorWhite,
      title: Container(
        margin: const EdgeInsets.only(left: 8),
        child: child ??
            Text(
              title ?? '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      centerTitle: false,
      actions: [
        if (isShowNotification)
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(SvgPath.icBellRedDot),
          ),
        if (isShowSearch)
          IconButton(
            icon: SvgPicture.asset(SvgPath.icSeach),
            onPressed: onTapSearch,
          ),
      ],
      toolbarHeight: child != null ? kToolbarHeight + 20 : kToolbarHeight,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(child != null ? kToolbarHeight + 20 : kToolbarHeight);
}
