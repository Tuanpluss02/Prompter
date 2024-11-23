import 'package:base/domain/data/entities/post_entity.dart';

class CreateNewPostPageData {
  final NewPostAction action;
  const CreateNewPostPageData({required this.action});
}

class EditPostPageData {
  final PostEntity postNeedEdit;
  const EditPostPageData({required this.postNeedEdit});
}

enum NewPostAction {
  text,
  image,
  link,
  hastag,
  mention,
}

class NewPostPageData {
  final RouteNewPostType type;
  final CreateNewPostPageData? createNewPostPageData;
  final EditPostPageData? editPostPageData;

  NewPostPageData({
    required this.type,
    this.createNewPostPageData,
    this.editPostPageData,
  }) : assert(type == RouteNewPostType.create && createNewPostPageData != null || type == RouteNewPostType.edit && editPostPageData != null);
}

enum RouteNewPostType { create, edit }
