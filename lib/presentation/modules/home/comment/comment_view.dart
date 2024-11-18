import 'package:base/presentation/modules/home/components/text_content.dart';
import 'package:base/presentation/modules/home/components/user_section.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:flutter/material.dart';

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
        TextContent(
          content: postComment.comment.content,
          images: postComment.comment.images,
        ),
      ],
    );
  }
}
