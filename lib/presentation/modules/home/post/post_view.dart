import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_color.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/presentation/modules/home/comment/comment_section.dart';
import 'package:base/presentation/modules/home/components/media_view.dart';
import 'package:base/presentation/modules/home/components/text_content.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostView extends GetView<HomeController> {
  const PostView({super.key, required this.news, this.isDetailView = false});

  final PostNewsFeed news;
  final bool isDetailView;

  @override
  Widget build(BuildContext context) {
    var content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPostAuthor(),
        const SizedBox(height: 10),
        _buildPostText(),
        _buildPostMedia(),
        const SizedBox(height: 10),
        _buildPostReact(),
        Divider(),
        if (isDetailView) ...[
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Comments',
              style: AppTextStyles.s16w700,
            ),
          ),
          Divider(),
          const SizedBox(height: 10),
          CommentSection(postId: news.post.id!),
        ],
      ],
    );
    return isDetailView
        ? Scaffold(
            backgroundColor: AppColors.backgroundColor,
            body: SafeArea(
              child: SmartRefresher(
                controller: controller.postDetailRefreshController,
                onRefresh: () {
                  controller.getComments(news.post.id!);
                  controller.postDetailRefreshController.refreshCompleted();
                },
                child: SingleChildScrollView(
                  child: content,
                ),
              ),
            ),
            appBar: AppBar(
              title: Text('Post Detail'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              Get.to(() => PostView(news: news, isDetailView: true));
            },
            child: content,
          );
  }

  _buildPostMedia() {
    return Visibility(
      visible: (news.post.images?.isNotEmpty ?? false),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: MediaView(images: news.post.images ?? []),
      ),
    );
  }

  _buildPostAuthor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: UserSection(user: news.author, timeAgo: news.post.createdAt),
    );
  }

  _buildPostReact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ScaleButton(
            onTap: () => controller.likePost(news),
            child: Row(
              children: [
                SvgPicture.asset(controller.isPostLiked(news) ? SvgPath.icHeartFilled : SvgPath.icHeart),
                const SizedBox(width: 5),
                Text(news.post.likes?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
              ],
            ),
          ),
          SizedBox(width: 15),
          ScaleButton(
            onTap: () {},
            child: Row(
              children: [
                SvgPicture.asset(SvgPath.icComment),
                const SizedBox(width: 5),
                Text(news.post.comments?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
              ],
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
  }
}
