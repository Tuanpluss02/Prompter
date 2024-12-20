import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'root_controller.dart';

const List<NavigationBarItem> navigationBarItems = <NavigationBarItem>[
  (selectedSvg: SvgPath.icHomeFilled, unSelectedSvg: SvgPath.icHomeOutlined, isMiddleButton: false),
  (selectedSvg: SvgPath.icSearchFilled, unSelectedSvg: SvgPath.icSearchOutlined, isMiddleButton: false),
  (selectedSvg: '', unSelectedSvg: '', isMiddleButton: true),
  (selectedSvg: SvgPath.icGridFilled, unSelectedSvg: SvgPath.icGridOutlined, isMiddleButton: false),
  (selectedSvg: SvgPath.icPersonFilled, unSelectedSvg: SvgPath.icPersonOutlined, isMiddleButton: false),
];

typedef NavigationBarItem = ({
  String unSelectedSvg,
  String selectedSvg,
  bool isMiddleButton,
});

class RootScreen extends BaseScreen<RootController> {
  const RootScreen({super.key});

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Color? get screenBackgroundColor => AppColors.backgroundColor;

  @override
  bool get wrapWithSafeArea => true;

  @override
  Widget? buildBottomNavigationBar(BuildContext context) {
    return Obx(() => Opacity(
          opacity: controller.currentIndex.value == 3 ? 0.8 : 1.0,
          child: Container(
            height: 60.0,
            color: AppColors.navigationBarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navigationBarItems
                  .asMap()
                  .entries
                  .map(
                    (MapEntry<int, NavigationBarItem> e) => e.value.isMiddleButton == false
                        ? Obx(() => GestureDetector(
                              child: SvgPicture.asset(
                                controller.currentIndex.value == e.key ? e.value.selectedSvg : e.value.unSelectedSvg,
                                width: 24.0,
                                height: 24.0,
                              ),
                              onTap: () => controller.onNavItemTaped(e.key),
                            ))
                        : _buildAddButton(),
                  )
                  .toList(),
            ),
          ),
        ));
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(() => IndexedStack(
          index: controller.currentIndex.value > 2 ? controller.currentIndex.value - 1 : controller.currentIndex.value,
          children: controller.screens,
        ));
  }

  Widget _buildAddButton() {
    return Container(
      width: 50.0,
      height: 50.0,
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xff0677e8),
        boxShadow: [
          BoxShadow(
            color: Color(0xff0677e8).withValues(alpha: 0.2),
            spreadRadius: 15,
            blurRadius: 20,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: GestureDetector(
        child: SvgPicture.asset(
          SvgPath.icPen,
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onTap: () => controller.onNavItemTaped(2),
      ),
    );
  }
}
