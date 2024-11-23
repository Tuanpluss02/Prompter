import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/constants/app_type.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/domain/data/page_data/new_post_page_data.dart';
import 'package:base/presentation/modules/home/components/media_view.dart';
import 'package:base/presentation/modules/home/components/text_content.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/routes/app_pages.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:base/presentation/shared/global/app_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class PostView extends GetView<HomeController> {
  final NewsFeedPost news;

  const PostView({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }

  _buildMainView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostAuthor(),
        const SizedBox(height: 10),
        _buildPostText(),
        _buildPostMedia(),
        const SizedBox(height: 10),
        _buildPostReact(),
        Divider(),
      ],
    );
  }

  _buildPostAuthor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: UserSection(
        user: news.author,
        timeAgo: news.post.createdAt,
        showOptions: news.author.id == controller.appProvider.user.value.id,
        onOptionsTap: () => showAppBottomSheet(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Color(0xff363636),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed(
                    AppRoutes.newPost,
                    arguments: NewPostPageData(
                      type: RouteNewPostType.edit,
                      editPostPageData: EditPostPageData(postNeedEdit: news.post),
                    ),
                  ),
                  child: ListTile(
                    trailing: SvgPicture.asset(SvgPath.icEdit),
                    title: Text(
                      'Edit',
                      style: AppTextStyles.s18w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.deletePost(news.post.id!),
                  child: ListTile(
                    trailing: SvgPicture.asset(SvgPath.icTrashbin),
                    title: Text(
                      'Delete',
                      style: AppTextStyles.s18w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildPostMedia() {
    return GetBuilder<HomeController>(
      id: 'post_${news.post.id}',
      init: controller,
      initState: (_) {},
      builder: (_) {
        return Visibility(
          visible: (news.post.images?.isNotEmpty ?? false),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: MediaView(images: news.post.images ?? []),
          ),
        );
      },
    );
  }

  _buildPostReact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ScaleButton(
            onTap: () => controller.likePost(news),
            child: GetBuilder<HomeController>(
              init: controller,
              id: 'post_${news.post.id}',
              initState: (_) {},
              builder: (_) {
                return Row(
                  children: [
                    SvgPicture.asset(controller.isPostLiked(news) ? SvgPath.icHeartFilled : SvgPath.icHeart),
                    const SizedBox(width: 5),
                    Text(news.post.likes?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
                  ],
                );
              },
            ),
          ),
          SizedBox(width: 15),
          ScaleButton(
            onTap: () => Get.toNamed(
              AppRoutes.comment,
              arguments: news,
            ),
            child: GetBuilder<HomeController>(
              init: controller,
              id: 'post_${news.post.id}',
              initState: (_) {},
              builder: (_) {
                return Row(
                  children: [
                    SvgPicture.asset(SvgPath.icComment),
                    const SizedBox(width: 5),
                    Text(news.post.comments?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
                  ],
                );
              },
            ),
          ),
          SizedBox(width: 15),
          ScaleButton(
            onTap: () {},
            child: SvgPicture.asset(SvgPath.icShare),
          ),
        ],
      ),
    );
  }

  _buildPostText() {
    return GetBuilder<HomeController>(
      init: controller,
      id: 'post_${news.post.id}',
      initState: (_) {},
      builder: (_) {
        return Visibility(
          visible: (news.post.content?.isNotEmpty ?? false),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextContent(
              content: news.post.content ?? '',
              hasMedia: news.post.images?.isNotEmpty ?? false,
            ),
          ),
        );
      },
    );
  }
}
