import 'package:base/common/constants/app_assets_path.dart';
import 'package:base/common/constants/app_text_styles.dart';
import 'package:base/common/constants/app_type.dart';
import 'package:base/common/utils/extension.dart';
import 'package:base/presentation/modules/home/comment/comment_controller.dart';
import 'package:base/presentation/modules/home/components/media_view.dart';
import 'package:base/presentation/modules/home/components/text_content.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommentView extends GetView<CommentController> {
  final PostComment postComment;
  const CommentView({super.key, required this.postComment});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      id: 'comment_${postComment.comment.id}',
      init: controller,
      builder: (_) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Visibility(
                visible: postComment.comment.content?.isNotEmpty ?? false,
                child: TextContent(
                  content: postComment.comment.content,
                  hasMedia: postComment.comment.images?.isNotEmpty ?? false,
                ),
              ),
            ),
            Visibility(
              visible: postComment.comment.images?.isNotEmpty ?? false,
              child: MediaView(
                images: postComment.comment.images ?? [],
                maxHeight: Get.width * 0.4,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () => controller.likeComment(postComment),
                child: Row(
                  children: [
                    SvgPicture.asset(Get.find<CommentController>().isCommentLiked(postComment) ? SvgPath.icHeartFilled : SvgPath.icHeart),
                    const SizedBox(width: 5),
                    Text(postComment.comment.likes?.length.toShortString() ?? '', style: AppTextStyles.s14w600),
                  ],
                ),
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
