import 'package:base/app/constants/firebase_collection_keys.dart';
import 'package:chatview/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference _chatMessagesCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.chatMessagesCollection);

  Future<void> saveMessage(Message message) async {
    await _chatMessagesCollection.add(message.toJson());
  }

  Stream<QuerySnapshot> getMessages() {
    return _chatMessagesCollection.orderBy('createdAt', descending: true).snapshots();
  }
}
