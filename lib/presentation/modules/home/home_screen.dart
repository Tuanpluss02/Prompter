import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_strings.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/presentation/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'home_controller.dart';

class HomeScreen extends BaseScreen<HomeController> {
  const HomeScreen({super.key});

  @override
  bool get wrapWithSafeArea => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(AppStrings.appName.toUpperCase(), style: TextStyle(fontFamily: 'Larsseit', fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 5)),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      // child: ListView.builder(itemBuilder: controller.itemBuilder, itemCount: controller.itemCount),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            // decoration: BoxDecoration(
            //   color: AppColors.postBackgroundColor,
            //   borderRadius: BorderRadius.circular(10),
            // ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(width: 14),
                    _buildAvatarName(),
                    Spacer(),
                    GestureDetector(onTap: () {}, child: const Icon(Icons.more_vert)),
                  ],
                ),
                const SizedBox(height: 10),
                SelectableText(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgPath.icHeart),
                          const SizedBox(width: 5),
                          Text('325', style: AppTextStyles.s14w600),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgPath.icComment),
                          const SizedBox(width: 5),
                          Text('1000', style: AppTextStyles.s14w600),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(SvgPath.icShare),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildAvatarName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: NetworkImage(AppStrings.defaultNetworkAvatar),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.appProvider.user.value.displayName ?? '',
              style: AppTextStyles.s16w700,
            ),
            Text(
              '@${controller.appProvider.user.value.username}',
              style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
            ),
            Text(
              timeago.format(DateTime(2021, 10, 10)),
              style: AppTextStyles.s12w400.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
