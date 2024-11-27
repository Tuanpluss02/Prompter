import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
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
      surfaceTintColor: Colors.transparent,
      title: Text(
        'Search',
        style: AppTextStyles.s28w500,
      ),
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppTextField(
            controller: controller.searchController,
            onChanged: controller.onSearchChanged,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(SvgPath.icSearchOutlined),
            ),
            hintText: 'Search for people, posts, and more',
            hintStyle: AppTextStyles.s16w400.copyWith(color: Colors.grey),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Obx(() => ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final result = controller.searchResults[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    // Search result, can be user or post
                    child: ListTile(
                      title: Text(result is UserEntity ? result.displayName ?? '' : (result as PostEntity).content ?? ''),
                      subtitle: Text(result is UserEntity ? result.username ?? '' : (result as PostEntity).authorId ?? ''),
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
