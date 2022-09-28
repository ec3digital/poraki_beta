import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatMessages {
  String? senderId;
  String? msg;
  Timestamp? sentIn;

  ChatMessages(
      {required this.senderId,
        required this.msg,
      required this.sentIn});

  ChatMessages.fromJson(Map<dynamic, dynamic> json) {
    //print('ChatMessages.fromJson');
    msg = json['msg'].toString();
    senderId = json['senderId'].toString();
    sentIn = Timestamp.fromMillisecondsSinceEpoch(int.parse(json['sentIn'].toString())); //Timestamp.now();
  }

  ChatMessages.fromSnapshot(DataSnapshot snapshot) {
    //print('ChatMessages.fromJson');
    msg = snapshot.child("msg").toString();
    senderId = snapshot.child("senderId").toString();
    sentIn = Timestamp.fromMillisecondsSinceEpoch(int.parse(snapshot.child("sentIn").toString())); //Timestamp.now();
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "sentIn": new DateTime.now().millisecondsSinceEpoch,
      "msg": msg,
    };
  }

  // factory ChatMessages.fromDocument(DocumentSnapshot documentSnapshot) {
  //   String msgBy = documentSnapshot.get("msgBy");
  //   // String timestamp = documentSnapshot.get("timestamp");
  //   String msgText = documentSnapshot.get("msgText");
  //
  //   return ChatMessages(
  //       msgBy: msgBy,
  //       // timestamp: timestamp,
  //       msgText: msgText);
  // }

}
