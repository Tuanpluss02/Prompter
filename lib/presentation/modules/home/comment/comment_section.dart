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
      init: controller,
      initState: (_) async {
        controller.commentList.clear();
        final comments = await controller.getComments(postId);
        controller.commentList.addAll(comments);
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
    // return FutureBuilder(
    //     future: controller.getComments(postId),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(child: AppLoadingIndicator());
    //       }
    //       if (snapshot.hasError) {
    //         return Center(child: Text('Error: ${snapshot.error}'));
    //       }
    //       final items = snapshot.data as List<PostComment>;
    //       return Visibility(
    //         visible: items.isNotEmpty,
    //         replacement: Center(child: Text('No comments')),
    //         child: ListView.builder(
    //           shrinkWrap: true,
    //           physics: NeverScrollableScrollPhysics(),
    //           itemCount: items.length,
    //           itemBuilder: (context, index) {
    //             final comment = items[index];
    //             return CommentView(postComment: comment);
    //           },
    //         ),
    //       );
    //     });
  }
}
