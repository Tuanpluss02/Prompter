import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  Future<UserService> init() async {
    return this;
  }

  Future<void> createUser(String userId, String username, String email) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await userRef.set({
      'username': username,
      'email': email,
      'profileImage': '',
      'bio': '',
      'followers': [],
      'following': [],
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'postCount': 0,
      'likeCount': 0,
    });
  }

  Future<void> followUser(String currentUserId, String targetUserId) async {
    final currentUserRef = FirebaseFirestore.instance.collection('users').doc(currentUserId).collection('following').doc(targetUserId);

    final targetUserRef = FirebaseFirestore.instance.collection('users').doc(targetUserId).collection('followers').doc(currentUserId);

    await currentUserRef.set({
      'followingId': FirebaseFirestore.instance.collection('users').doc(targetUserId),
      'createdAt': FieldValue.serverTimestamp(),
    });

    await targetUserRef.set({
      'followerId': FirebaseFirestore.instance.collection('users').doc(currentUserId),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
