import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:poraki/app/theme/app_theme.dart';
import '../../data/models/chatMsgs.dart';
import '../auth/login/login_controller.dart';
import '../home/home_controller.dart';
import '../home/widgets/app_bar_home.dart';
import '../home/widgets/drawer_home.dart';

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
    final LoginController _loginController = Get.find();
    final TextEditingController txtMsg = TextEditingController();
    Color textColor = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: _loginController.colorFromHex(_loginController.listCore
              .where((coreItem) => coreItem.coreChave == 'backLight')
              .first
              .coreValor
              .toString()),
          title: Text(
            'Mensagens',
            style: TextStyle(fontSize: 25, color: textColor),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 26),
        decoration: BoxDecoration(
          color: _loginController.colorFromHex(_loginController.listCore
              .where((coreItem) => coreItem.coreChave == 'backLight')
              .first
              .coreValor
              .toString()),

          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     AppColors.primaryBackground,
          //     AppColors.secondaryBackground
          //   ],
          // ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child:
                    //
                    //     GroupedListView<ChatMessages,DateTime>(
                    //       padding: const EdgeInsets.all(8),
                    //       reverse: true,
                    //       order: GroupedListOrder.DESC,
                    //       floatingHeader: true,
                    //       useStickyGroupSeparators: true,
                    //       elements: listMsgs,
                    //       groupBy: (listMsgs) => DateTime(listMsgs.sentIn!.toDate().year,listMsgs.sentIn!.toDate().month,listMsgs.sentIn!.toDate().day),
                    //       groupHeaderBuilder: (ChatMessages msg) => SizedBox(
                    //         height: 40,
                    //         child: Center(child: Card(color: AppColors.darkText, child: Padding(padding: const EdgeInsets.all(8),child: Text(DateFormat.yMMMd().format(msg.sentIn!.toDate()),style: TextStyle(color: AppColors.primaryLight),),),),),
                    //       ),
                    //       itemBuilder: (context, ChatMessages msg) => Align(
                    //         alignment: msg.senderId == 'eyCv21RfaURoMn0SUndCg6LPyJP2' ? Alignment.centerRight : Alignment.centerLeft,
                    //         child: Card(
                    //           elevation: 8, child: Padding(padding: const EdgeInsets.all(12),child: Text(msg.msg.toString()),),
                    //         ),
                    //       ),
                    //
                    //       ),
                    //
                    //     )

                    FirebaseAnimatedList(
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
                        _loginController.usuGuid
                        ? TextAlign.right
                        : TextAlign.left,
                    style: TextStyle(color: AppColors.darkText, fontSize: 14.0),
                  ),
                  subtitle: result.senderId.toString() ==
                      _loginController.usuGuid
                      ? WidgetMessageSent(result.msg.toString())
                      : WidgetMessageReceived(result.msg.toString()),
                );
              },
            )),

            const Divider(height: 2, thickness: 2),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: txtMsg,
                    style: TextStyle(
                        color: AppColors.darkText,
                        fontSize: 16,
                        fontStyle: FontStyle.italic),
                    onChanged: (value) {
                      msg = value;
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: "Digite a mensagem...",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: accentColor,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.send_rounded,
                        size: 24,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        var novaMsg = new ChatMessages(
                            senderId: _loginController.usuGuid, msg: msg, sentIn: Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
                        refDataInstance.push().set(novaMsg.toJson());
                        txtMsg.text = "";
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
