import 'package:base/app/constants/firebase_collection_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxService {
  final _postCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.postsCollection);
  final _userCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.usersCollection);

  Future<void> createPost(String userId, String content, {String? imageUrl}) async {
    await _postCollection.doc().set({
      'userId': _userCollection.doc(userId),
      'content': content,
      'imageUrl': imageUrl ?? '',
      'likes': 0,
      'commentsCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    final userRef = _userCollection.doc(userId);
    await userRef.update({
      'postCount': FieldValue.increment(1),
    });
  }

  Future<void> likePost(String userId, String postId) async {
    final likeRef = _postCollection.doc(postId).collection(FirebaseCollectionKeys.likesCollection).doc(userId);

    await likeRef.set({
      'userId': _userCollection.doc(userId),
      'createdAt': FieldValue.serverTimestamp(),
    });

    final postRef = _postCollection.doc(postId);
    await postRef.update({
      'likes': FieldValue.increment(1),
    });
  }

  Future<void> addComment(String userId, String postId, String content) async {
    final commentRef = _postCollection.doc(postId).collection(FirebaseCollectionKeys.commentsCollection).doc();

    await commentRef.set({
      'userId': _userCollection.doc(userId),
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final postRef = _postCollection.doc(postId);
    await postRef.update({
      'commentsCount': FieldValue.increment(1),
    });
  }
}
