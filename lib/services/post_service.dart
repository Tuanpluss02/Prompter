import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxService {
  final postRef = FirebaseFirestore.instance.collection('posts').doc();
  Future<PostService> init() async {
    return this;
  }

  Future<void> createPost(String userId, String content, {String? imageUrl}) async {
    await postRef.set({
      'userId': FirebaseFirestore.instance.collection('users').doc(userId),
      'content': content,
      'imageUrl': imageUrl ?? '',
      'likes': 0,
      'commentsCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    await userRef.update({
      'postCount': FieldValue.increment(1),
    });
  }

  Future<void> likePost(String userId, String postId) async {
    final likeRef = FirebaseFirestore.instance.collection('posts').doc(postId).collection('likes').doc(userId);

    await likeRef.set({
      'userId': FirebaseFirestore.instance.collection('users').doc(userId),
      'createdAt': FieldValue.serverTimestamp(),
    });

    final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    await postRef.update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> addComment(String userId, String postId, String content) async {
    final commentRef = FirebaseFirestore.instance.collection('posts').doc(postId).collection('comments').doc();

    await commentRef.set({
      'userId': FirebaseFirestore.instance.collection('users').doc(userId),
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Cập nhật số lượng bình luận cho bài viết
    final postRef = FirebaseFirestore.instance.collection('posts').doc(postId);
    await postRef.update({
      'commentsCount': FieldValue.increment(1),
    });
  }
}
