import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/post/post_view.dart';
import 'package:base/presentation/modules/profile/profile_binding.dart';
import 'package:base/presentation/modules/root/root_controller.dart';
import 'package:base/presentation/modules/search/search_controller.dart'
    as search_controller;
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/global/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchScreen extends BaseScreen<search_controller.SearchController> {
  const SearchScreen({super.key});

  @override
  bool get wrapWithSafeArea => true;
  @override
  Widget buildScreen(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildAppbar(),
        SliverToBoxAdapter(child: SizedBox(height: 16)),
        Obx(() => SliverVisibility(
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Users',
                  style: AppTextStyles.s16w700,
                ),
              ),
            ),
            visible: controller.searchUserResults.isNotEmpty)),
        Obx(() => SliverList.builder(
            itemCount: controller.searchUserResults.length,
            itemBuilder: (context, index) {
              final result = controller.searchUserResults[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: GestureDetector(
                  onTap: () => result.id != controller.appProvider.user.value.id
                      ? Get.toNamed(
                          AppRoutes.profile,
                          arguments: ProfilePageData(userId: result.id!),
                        )
                      : Get.find<RootController>().onNavItemTaped(4),
                  child: UserSection(
                    user: result,
                    additionalWidget: Text(
                      '${result.followers!.length.toShortString()} followers',
                      style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
              );
            })),
        Obx(() => SliverVisibility(
            visible: controller.searchPostResults.isNotEmpty,
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  'Posts',
                  style: AppTextStyles.s16w700,
                ),
              ),
            ))),
        Obx(() => SliverList.builder(
            itemCount: controller.searchPostResults.length,
            itemBuilder: (context, index) {
              final result = controller.searchPostResults[index];
              return Column(
                children: [
                  PostView(news: result),
                  Divider(),
                ],
              );
            })),
      ],
    );
  }

  _buildAppbar() {
    return SliverAppBar(
      collapsedHeight: 80.0,
      expandedHeight: 120,
      floating: false,
      pinned: true,
      centerTitle: true,
      leadingWidth: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppTextField(
            onFieldSubmitted: controller.onSearchChanged,
            textInputAction: TextInputAction.search,
            controller: controller.textSearchController,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(SvgPath.icSearchOutlined),
            ),
            hintText: 'Search for people, posts, and more',
            hintStyle: AppTextStyles.s16w400.copyWith(color: Colors.grey),
          ),
        ),
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Search',
            style: AppTextStyles.s28w500,
          ),
        ),
      ),
    );
  }
}
