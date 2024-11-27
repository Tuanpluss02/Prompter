import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/post/post_view.dart';
import 'package:base/presentation/modules/search/search_controller.dart' as search_controller;
import 'package:base/presentation/shared/global/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchScreen extends BaseScreen<search_controller.SearchController> {
  const SearchScreen({super.key});

  @override
  bool get wrapWithSafeArea => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 120,
      surfaceTintColor: Colors.transparent,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search',
            style: AppTextStyles.s28w500,
          ),
          SizedBox(height: 8),
          AppTextField(
            onFieldSubmitted: controller.onSearchChanged,
            textInputAction: TextInputAction.search,
            controller: controller.searchController,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(SvgPath.icSearchOutlined),
            ),
            hintText: 'Search for people, posts, and more',
            hintStyle: AppTextStyles.s16w400.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverToBoxAdapter(
        //   child:
        // ),
        SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverVisibility(
            sliver: SliverToBoxAdapter(
              child: Obx(
                () => controller.searchUserResults.isEmpty
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Users',
                          style: AppTextStyles.s16w700,
                        ),
                      ),
              ),
            ),
            visible: controller.searchUserResults.isNotEmpty),
        Obx(() => SliverList.builder(
            itemCount: controller.searchUserResults.length,
            itemBuilder: (context, index) {
              final result = controller.searchUserResults[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                // Search result, can be user or post
                child: UserSection(
                  user: result,
                  additionalWidget: Text(
                    '${result.postCount!.toShortString()} posts ${result.followers!.length.toShortString()} followers',
                    style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
                  ),
                ),
              );
            })),
        SliverVisibility(
            visible: controller.searchPostResults.isNotEmpty,
            sliver: SliverToBoxAdapter(
              child: Obx(
                () => controller.searchPostResults.isEmpty
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          'Posts',
                          style: AppTextStyles.s16w700,
                        ),
                      ),
              ),
            )),
        Obx(() => SliverList.builder(
            itemCount: controller.searchPostResults.length,
            itemBuilder: (context, index) {
              final result = controller.searchPostResults[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PostView(news: result),
                  ),
                  Divider()
                ],
              );
            })),
      ],
    );
  }
}
