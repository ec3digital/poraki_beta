import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:poraki/app/modules/chats/custom_shape.dart';
import 'package:poraki/app/services/chatMsgs_service.dart';
import 'package:poraki/app/theme/app_theme.dart';

import '../../data/models/chatMsgs.dart';
import '../../services/fbporaki_service.dart';
import '../home/widgets/gradient_header_home.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  List<String> listStrings = <String>[""];
  List<ChatMessages> listMsgs = [];

  final refDataInstance =
      FirebaseDatabase.instance.ref('akichats').child('1'); //.child('msgs');
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 26),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryBackground,
                AppColors.secondaryBackground
              ],
            ),
          ),
          child: SingleChildScrollView(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02,
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Nova msg',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    onChanged: (value) {
                      msg = value;
                    },
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 4.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ElevatedButton.icon(
                      onPressed: () async {
                        var novaMsg = new ChatMessages(
                            senderId: 'eyCv21RfaURoMn0SUndCg6LPyJP2', msg: msg);
                        refDataInstance
                            .push()
                            .set(novaMsg.toJson()); //..asStream();
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('OK')),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                      child: FirebaseAnimatedList(
                    shrinkWrap: true,
                    query: refDataInstance,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      var result = ChatMessages.fromJson(
                          snapshot.value as Map<dynamic, dynamic>);
                      return ListTile(
                        title: Text(
                          DateFormat("dd/MM/yyyy HH:mm")
                              .format(result.sentIn!.toDate()),
                          textAlign: result.senderId.toString() ==
                                  "eyCv21RfaURoMn0SUndCg6LPyJP2"
                              ? TextAlign.right
                              : TextAlign.left,
                          style: TextStyle(
                              color: AppColors.darkText, fontSize: 14.0),
                        ),
                        subtitle: result.senderId.toString() ==
                                "eyCv21RfaURoMn0SUndCg6LPyJP2"
                            ? WidgetMessageSent(result.msg.toString())
                            : WidgetMessageReceived(result.msg.toString()),
                      );
                    },
                  )),
                ],
              ),
            ),
          ]))),
    );
  }

  WidgetMessageSent(String message) {
    return Padding(
      padding: EdgeInsets.only(right: 1.0, left: 10, top: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: 30),
          Flexible(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.darkText,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: Text(
                    message,
                    style:
                        TextStyle(color: AppColors.primaryLight, fontSize: 14),
                  ),
                ),
              ),
              //CustomPaint(painter: CustomShape(AppColors.darkText)),
            ],
          ))
        ],
      ),
    );
  }

  WidgetMessageReceived(String message) {
    return Padding(
        padding: EdgeInsets.only(right: 10.0, left: 1.0, top: 5, bottom: 10),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          SizedBox(height: 30),
          Flexible(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(18),
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      message,
                      style: TextStyle(color: AppColors.darkText, fontSize: 14),
                    ),
                  ),
                ]),
          ),
        ]));
  }
}
