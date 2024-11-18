import 'package:base/common/constants/firebase_collection_keys.dart';
import 'package:base/common/utils/generate_id.dart';
import 'package:base/domain/data/entities/comment_entity.dart';
import 'package:base/domain/data/entities/post_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxService {
  final _postCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.postsCollection);
  final _commentCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.commentsCollection);

  /// Create a new post
  ///
  /// This method creates a new post with the given userId, content, and optional imageUrl.
  /// It sets the initial values for the post's userId, content, imageUrl, likes, commentsCount, createdAt, and updatedAt.
  /// It also increments the postCount of the user who created the post.
  Future<PostEntity> createPost(PostEntity newpost) async {
    if (newpost.id == null || newpost.id!.isEmpty) {
      newpost = newpost.copyWith(id: generateUniqueId());
    }
    newpost = newpost.copyWith(createdAt: DateTime.now());
    final postRef = _postCollection.doc(newpost.id);
    await postRef.set(newpost.toJson());
    return await getPostById(newpost.id!);
  }

  Future<PostEntity> getPostById(String postId) async {
    final postSnapshot = await _postCollection.doc(postId).get();
    return PostEntity.fromJson(postSnapshot.data()!);
  }

  Future<List<PostEntity>> getPostsByUserId(String userId) async {
    final postsSnapshot = await _postCollection.where('authorId', isEqualTo: userId).get();
    return postsSnapshot.docs.map((e) => PostEntity.fromJson(e.data())).toList();
  }

  Future<List<PostEntity>> getNewsFeed() async {
    final postsSnapshot = await _postCollection.orderBy('createdAt', descending: true).get();
    return postsSnapshot.docs.map((e) => PostEntity.fromJson(e.data())).toList();
  }

  Future<void> removePost(String postId) async {
    final postRef = _postCollection.doc(postId);
    await postRef.delete();
  }

  /// Like a post
  ///
  /// This method allows a user to like a post.
  /// It updates the likes collection of the post and increments the likes count of the post.
  Future<void> updatePostLike(String userId, String postId) async {
    var post = await getPostById(postId);
    if (post.likes?.contains(userId) ?? false) {
      final index = post.likes!.indexWhere((element) => element == userId);
      post.likes!.removeAt(index);
    } else {
      post.likes!.add(userId);
    }
    final postRef = _postCollection.doc(postId);
    await postRef.update({
      'likes': post.likes,
    });
  }

  Future<List<CommentEntity>> getCommentsByPostId(String postId) async {
    final commentIds = await getPostById(postId).then((value) => value.comments);
    List<CommentEntity> comments = [];
    for (final commentId in commentIds!) {
      final commentSnapshot = await _commentCollection.doc(commentId).get();
      comments.add(CommentEntity.fromJson(commentSnapshot.data()!));
    }
    return comments;
  }

  /// Add a comment to a post
  ///
  /// This method allows a user to add a comment to a post.
  /// It updates the comments collection of the post and increments the comments count of the post.
  // Future<void> addComment(String userId, String postId, CommentEntity comment) async {
  //   final commentRef = _postCollection.doc(postId).collection(FirebaseCollectionKeys.commentsCollection).doc();
  // }
}
