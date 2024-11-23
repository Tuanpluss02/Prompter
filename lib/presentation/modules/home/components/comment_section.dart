import 'package:base/presentation/modules/home/comment/comment_controller.dart';
import 'package:base/presentation/modules/home/components/comment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentSection extends GetView<CommentController> {
  final String postId;
  const CommentSection({super.key, required this.postId});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      id: 'post_comment_$postId',
      init: controller,
      initState: (_) async {
        controller.commentList.clear();
        final comments = await controller.getComments(postId);
        controller.commentList.addAll(comments);
        controller.update(['post_comment_$postId']);
      },
      builder: (_) {
        return Visibility(
          visible: controller.commentList.isNotEmpty,
          replacement: Center(child: Text('No comments')),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.commentList.length,
            itemBuilder: (context, index) {
              return CommentView(postComment: controller.commentList[index]);
            },
          ),
        );
      },
    );
  }
}
