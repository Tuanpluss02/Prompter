import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:base/app/constants/firebase_collection_keys.dart';

class ChatService {
  final CollectionReference _chatMessagesCollection =
      FirebaseFirestore.instance.collection(FirebaseCollectionKeys.chatMessagesCollection);

  Future<void> saveMessage(String message, String sentBy, DateTime createdAt) async {
    await _chatMessagesCollection.add({
      'message': message,
      'sentBy': sentBy,
      'createdAt': createdAt,
    });
  }

  Stream<QuerySnapshot> getMessages() {
    return _chatMessagesCollection.orderBy('createdAt', descending: true).snapshots();
  }
}
