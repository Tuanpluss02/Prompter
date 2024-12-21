import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTabBarWidget extends StatelessWidget {
  const AppTabBarWidget({
    super.key,
    this.tabController,
    required this.listTab,
    this.onTap,
  });

  final TabController? tabController;
  final List<Widget> listTab;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 0,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.greyF6F4F7,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
        child: TabBar(
            onTap: onTap,
            controller: tabController,
            indicatorWeight: 0,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              color: AppColors.black272727,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                ),
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 1,
                )
              ],
            ),
            labelStyle: AppTextStyles.s14w700.copyWith(color: AppColors.yellowFFDC00),
            unselectedLabelStyle: AppTextStyles.s14w700.copyWith(color: AppColors.black28303F),
            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            labelColor: AppColors.yellowFFDC00,
            unselectedLabelColor: AppColors.grey4F4950,
            automaticIndicatorColorAdjustment: false,
            tabs: listTab),
      ),
    );
  }
}
