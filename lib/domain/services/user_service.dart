import 'package:base/common/constants/firebase_collection_keys.dart';
import 'package:base/domain/data/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  final _userCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.usersCollection);

  DateTime get _createdTime => DateTime.now();

  Future<bool> checkUserExists(String userId) async {
    final userDoc = await _userCollection.doc(userId).get();
    return userDoc.exists;
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
    );
    await userRef.set(newUser.toJson());
  }

  Future<UserEntity?> getUserById(String userId) async {
    final userDoc = await _userCollection.doc(userId).get();
    if (!userDoc.exists) {
      return null;
    }
    return UserEntity.fromJson(userDoc.data()!);
  }

  Future<bool> isUsernameExists(String username) async {
    final querySnapshot = await _userCollection.where('username', isEqualTo: username).get();
    return querySnapshot.docs.isNotEmpty;
  }

  Future<List<UserEntity>> searchUsers(String query) async {
    final querySnapshot = await _userCollection
        .where('displayName', isGreaterThanOrEqualTo: query, isLessThanOrEqualTo: '$query\uf8ff')
        .where('username', isGreaterThanOrEqualTo: query, isLessThanOrEqualTo: '$query\uf8ff')
        .get();
    return querySnapshot.docs.map((doc) => UserEntity.fromJson(doc.data())).toList();
  }

  Future<void> updateUser(UserEntity user) async {
    final userRef = _userCollection.doc(user.id);
    await userRef.update(user.toJson());
  }
}
