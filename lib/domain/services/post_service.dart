import 'package:base/common/constants/firebase_collection_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class PostService extends GetxService {
  final _postCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.postsCollection);
  final _userCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.usersCollection);

  /// Create a new post
  ///
  /// This method creates a new post with the given userId, content, and optional imageUrl.
  /// It sets the initial values for the post's userId, content, imageUrl, likes, commentsCount, createdAt, and updatedAt.
  /// It also increments the postCount of the user who created the post.
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

  /// Like a post
  ///
  /// This method allows a user to like a post.
  /// It updates the likes collection of the post and increments the likes count of the post.
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

  /// Add a comment to a post
  ///
  /// This method allows a user to add a comment to a post.
  /// It updates the comments collection of the post and increments the comments count of the post.
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
