import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/presentation/modules/home/home_controller.dart';

enum NewPostAction {
  text,
  image,
  link,
  hastag,
  mention,
}

enum RouteNewPostType { create, edit, comment }

class NewPostPageData {
  final RouteNewPostType type;
  final CreateNewPostPageData? createNewPostPageData;
  final EditPostPageData? editPostPageData;
  final CommentPostPageData? commentPostPageData;

  NewPostPageData({
    required this.type,
    this.createNewPostPageData,
    this.editPostPageData,
    this.commentPostPageData,
  }) : assert(type == RouteNewPostType.create && createNewPostPageData != null ||
            type == RouteNewPostType.edit && editPostPageData != null ||
            type == RouteNewPostType.comment && commentPostPageData != null);
}

class CreateNewPostPageData {
  final NewPostAction action;
  const CreateNewPostPageData({required this.action});
}

class EditPostPageData {
  final PostEntity postNeedEdit;
  const EditPostPageData({required this.postNeedEdit});
}

class CommentPostPageData {
  final PostNewsFeed newsfeedPost;
  const CommentPostPageData({required this.newsfeedPost});
}
