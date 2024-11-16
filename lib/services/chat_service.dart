import 'package:base/app/constants/firebase_collection_keys.dart';
import 'package:chatview/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference _chatMessagesCollection = FirebaseFirestore.instance.collection(FirebaseCollectionKeys.chatMessagesCollection);

  Future<void> saveMessage(Message message, String userId) async {
    await _chatMessagesCollection.doc(userId).collection('messages').add(message.toJson());
  }

  Future<List<Message>> getMessages(String userId) async {
    return await _chatMessagesCollection.doc(userId).collection('messages').get().then((querySnapshot) {
      return querySnapshot.docs.map((doc) => Message.fromJson(doc.data())).toList();
    });
  }
}
