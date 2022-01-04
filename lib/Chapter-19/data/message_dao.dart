import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_basics_2/Chapter-19/data/message.dart';

class MessageDao {
  final CollectionReference collection = FirebaseFirestore.instance.collection('messages');

  //Add saveMessage
  void saveMessage(Message message) {
    collection.add(message.toJson());
  }

  //Add getMessageStream
  Stream<QuerySnapshot> getMessageStream() {
    return collection.snapshots();
  }

}