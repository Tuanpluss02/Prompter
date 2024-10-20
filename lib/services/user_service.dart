import 'package:base/app/constants/firebase_collection_keys.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  final _userCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.usersCollection);
  Future<UserService> init() async {
    return this;
  }

  Future<void> createUser(String userId, String username, String email) async {
    final userRef = _userCollection.doc(userId);

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
    final currentUserRef = _userCollection.doc(currentUserId).collection('following').doc(targetUserId);

    final targetUserRef = _userCollection.doc(targetUserId).collection('followers').doc(currentUserId);

    await currentUserRef.set({
      'followingId': _userCollection.doc(targetUserId),
      'createdAt': FieldValue.serverTimestamp(),
    });

    await targetUserRef.set({
      'followerId': _userCollection.doc(currentUserId),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
