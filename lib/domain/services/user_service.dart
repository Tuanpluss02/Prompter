import 'package:base/app/constants/firebase_collection_keys.dart';
import 'package:base/app_provider.dart';
import 'package:base/domain/data/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<void> createUser(UserCredential user) async {
    final userRef = _userCollection.doc(user.user!.uid);
    final UserEntity newUser = UserEntity(
      id: user.user?.uid,
      displayName: user.user?.displayName,
      username: user.user?.email?.split('@')[0],
      email: user.user?.email,
      profileImage: user.user?.photoURL,
      createdAt: _createdTime,
      updatedAt: _createdTime,
    );
    await userRef.set(newUser.toJson());
  }

  Future<UserEntity> getUserInfo(String userId) async {
    final userDoc = await _userCollection.doc(userId).get();
    if (!userDoc.exists) {
      Get.find<AppProvider>().signOut();
      return const UserEntity();
    }
    return UserEntity.fromJson(userDoc.data()!);
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
