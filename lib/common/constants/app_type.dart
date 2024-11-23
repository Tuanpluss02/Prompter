import 'package:base/domain/data/entities/comment_entity.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:base/domain/data/entities/user_entity.dart';

class NewsFeedPost {
  PostEntity post;
  final UserEntity author;

  NewsFeedPost({required this.post, required this.author});
}

class PostComment {
  CommentEntity comment;
  final UserEntity author;

  PostComment({required this.comment, required this.author});
}
