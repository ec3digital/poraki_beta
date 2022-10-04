import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poraki/app/data/models/pessoa_nome.dart';
import 'package:poraki/app/data/models/pessoas.dart';

class Chats {
  String? chatId;
  String? customerId;
  String? sellerId;
  String? chatType;
  String? chatName;
  Timestamp? chatStart;
  Timestamp? chatEnd;
  PessoaNome? pessoaSeller;
  PessoaNome? pessoaCustomer;

  Chats({this.customerId, this.sellerId, this.chatType, this.chatName});

  Chats.fromJson(Map<dynamic, dynamic> jsonData) {
    //print(jsonData['PessoaSeller']);
    customerId = jsonData['customerId'].toString();
    sellerId = jsonData['sellerId'].toString();
    chatType = jsonData['chatType'].toString();
    chatName = jsonData['chatName'].toString();
    chatId = jsonData['chatId'].toString();
    chatStart = Timestamp.fromDate(DateTime.parse(jsonData['chatStart']));
    //chatEnd = Timestamp.fromDate(DateTime.parse(json['chatEnd']));
    pessoaSeller = PessoaNome.fromJson(jsonData['PessoaSeller']);
    pessoaCustomer = PessoaNome.fromJson(jsonData['PessoaCustomer']);
  }

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "sellerId": sellerId,
      "chatType": chatType,
      "chatName": chatName
    };
  }

}
