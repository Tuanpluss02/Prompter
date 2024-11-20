import 'package:base/presentation/modules/home/comment/comment_view.dart';
import 'package:base/presentation/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentSection extends GetView<HomeController> {
  const CommentSection({super.key, required this.postId});
  final String postId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: 'comment_$postId',
      init: controller,
      initState: (_) async {
        controller.commentList.clear();
        final comments = await controller.getComments(postId);
        controller.commentList.addAll(comments);
        controller.update(['comment_$postId']);
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
              final comment = controller.commentList[index];
              return CommentView(postComment: comment);
            },
          ),
        );
      },
    );
  }
}
