import 'package:base/app/constants/firebase_collection_keys.dart';
import 'package:base/data/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  final _userCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.usersCollection);

  String get _createdTime => DateTime.now().toIso8601String();

  /// Initializes the UserService
  /// This method is used to initialize the UserService and perform any necessary setup.
  Future<UserService> init() async {
    return this;
  }

  /// Creates a new user document in the Firestore collection
  /// [userId] is the unique identifier for the user
  /// [username] is the username of the user
  /// [email] is the email address of the user
  Future<void> createUser(String userId, String username, String email) async {
    final userRef = _userCollection.doc(userId);
    await userRef.set({
      'id': userId,
      'username': username,
      'email': email,
      'profileImage': '',
      'bio': '',
      'followers': [],
      'following': [],
      'createdAt': _createdTime,
      'updatedAt': _createdTime,
      'postCount': 0,
      'likeCount': 0,
    });
  }

  Future<User> getUserInfo(String userId) async {
    final userDoc = await _userCollection.doc(userId).get();
    if (!userDoc.exists) {
      throw Exception('User not found');
    }
    return User.fromJson(userDoc.data()!);
  }

  Future<bool> checkUserExists(String userId) async {
    final userDoc = await _userCollection.doc(userId).get();
    return userDoc.exists;
  }

  /// Follows a user
  /// [currentUserId] is the ID of the current user
  /// [targetUserId] is the ID of the user to be followed
  Future<void> followUser(String currentUserId, String targetUserId) async {
    final currentUserRef = _userCollection.doc(currentUserId).collection('following').doc(targetUserId);

    final targetUserRef = _userCollection.doc(targetUserId).collection('followers').doc(currentUserId);

    await currentUserRef.set({
      'followingId': _userCollection.doc(targetUserId),
      'createdAt': _createdTime,
    });

    await targetUserRef.set({
      'followerId': _userCollection.doc(currentUserId),
      'createdAt': _createdTime,
    });
  }
}
