import 'package:base/presentation/modules/home/components/media_view.dart';
import 'package:base/presentation/modules/home/components/text_content.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
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
        Divider(),
      ],
    );
  }
}
