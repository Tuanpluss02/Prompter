import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base/app/constants/app_assets_path.dart';
import 'package:base/app/constants/app_color.dart';
import 'package:base/app/localization/locale_keys.g.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GlobalBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final GlobalKey<ConvexAppBarState> convexAppBarState;

  const GlobalBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.convexAppBarState,
  });

  @override
  Widget build(BuildContext context) {
    return StyleProvider(
      style: Style(currentIndex),
      child: ConvexAppBar(
        key: convexAppBarState,
        items: _buildTabItems(currentIndex),
        height: 70,
        style: TabStyle.fixedCircle,
        initialActiveIndex: currentIndex,
        onTap: onTap,
        backgroundColor: AppColors.appColorWhite,
        activeColor: AppColors.black14081C,
        color: AppColors.grayA1A5B7,
        cornerRadius: 30,
        top: -24,
        shadowColor: AppColors.blackOpacity025,
        elevation: 6,
      ),
    );
  }

  List<TabItem> _buildTabItems(int currentIndex) {
    return [
      _buildTabItem(
          SvgPath.icHome, SvgPath.icHomeActive, tr(LocaleKeys.home), 0),
      _buildTabItem(SvgPath.icDiscover, SvgPath.icDiscoverActive,
          tr(LocaleKeys.explore), 1),
      TabItem(
        icon: Container(
          padding: const EdgeInsets.fromLTRB(10, 11, 10, 9),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex != 2 ? AppColors.black14081C : null,
            gradient: currentIndex == 2
                ? const LinearGradient(
                    colors: [
                      AppColors.black14081C,
                      AppColors.purple5D2582
                    ], // Adjust the gradient colors as needed
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
          ),
          child: Image.asset(
            ImagePath.imgMission,
            width: 20,
          ),
        ),
      ),
      _buildTabItem(
          SvgPath.icMarket, SvgPath.icMarketActive, tr(LocaleKeys.market), 3),
      _buildTabItem(SvgPath.icEstate, SvgPath.icEstateActive,
          tr(LocaleKeys.accessibility), 4),
    ];
  }

  TabItem _buildTabItem(
      String iconPath, String iconPathActive, String title, int index) {
    return TabItem(
      icon: SvgPicture.asset(
        currentIndex == index ? iconPathActive : iconPath,
      ),
      title: title,
    );
  }
}

class Style extends StyleHook {
  final int currentIndex;

  Style(this.currentIndex);

  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 5;

  @override
  double get iconSize => 24;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(
      fontSize: 13,
      color: color,
      fontWeight: FontWeight.w700,
    );
  }
}
