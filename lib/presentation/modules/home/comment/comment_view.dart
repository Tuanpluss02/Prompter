import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/presentation/modules/home/components/media_view.dart';
import 'package:base/presentation/modules/home/components/text_content.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:base/presentation/shared/animated/animated_scale_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key, required this.postComment});
  final PostComment postComment;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: UserSection(
            user: postComment.author,
            timeAgo: postComment.comment.createdAt,
          ),
        ),
        Visibility(
          visible: postComment.comment.content?.isNotEmpty ?? false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextContent(
              content: postComment.comment.content,
              hasMedia: postComment.comment.images?.isNotEmpty ?? false,
            ),
          ),
        ),
        Visibility(
          visible: postComment.comment.images?.isNotEmpty ?? false,
          child: MediaView(
            images: postComment.comment.images,
            maxHeight: Get.width * 0.4,
          ),
        ),
        SizedBox(height: 10),
        _buildPostReact(),
        Divider(),
      ],
    );
  }

  _buildPostReact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ScaleButton(
        onTap: () {},
        child: Row(
          children: [
            SvgPicture.asset(Get.find<HomeController>().isCommentLiked(postComment) ? SvgPath.icHeartFilled : SvgPath.icHeart),
            const SizedBox(width: 5),
            Text(postComment.comment.likes?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
          ],
        ),
      ),
    );
  }
}
