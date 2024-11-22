import 'package:base/common/constants/firebase_collection_keys.dart';
import 'package:base/presentation/shared/chat_view/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference _chatMessagesCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.chatMessagesCollection);

  Future<bool> checkIfMessageExists(String userId, String messageId) async {
    return await _chatMessagesUsersCollection(userId).doc(messageId).get().then((doc) => doc.exists);
  }

  Future<List<Message>> getMessages(String userId) async {
    return await _chatMessagesUsersCollection(userId).orderBy('createdAt').get().then((querySnapshot) {
      return querySnapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    });
  }

  Future<void> saveMessage(Message message, String userId) async {
    await _chatMessagesUsersCollection(userId).doc(message.id).set(message.toJson());
  }

  Future<void> updateMessage(Message message, String userId) async {
    final isMessageExists = await checkIfMessageExists(userId, message.id);
    if (!isMessageExists) {
      await saveMessage(message, userId);
    }
    await _chatMessagesUsersCollection(userId).doc(message.id).set(message.toJson());
  }

  CollectionReference<Map<String, dynamic>> _chatMessagesUsersCollection(String userId) => _chatMessagesCollection.doc(userId).collection(FirebaseCollectionKeys.chatMessagesSubCollection);
}
