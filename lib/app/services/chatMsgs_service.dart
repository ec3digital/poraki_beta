import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/chatMsgs.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:http/http.dart' as http;

class ChatMsgsService extends GetConnect {
  // LoginController _loginController = Get.find();
  FirebaseFirestore? _fbInstance;

  _iniFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    _fbInstance = FirebaseFirestore.instance;
  }

  Future<dynamic> listChatMsgsListen(String transId) async {
    print('listChatMsgsListen');
    await _iniFirebase();
    var msgsRef = FirebaseDatabase.instance.ref("/akichats/" + transId);
    //var ret = await msgsRef.child(transId).child("msgs").get();
    late Object ret;
    msgsRef.onValue.listen((DatabaseEvent event) {
    ret = event.snapshot.value!;
    // updateStarCount(data);
    });

    print("listen: " + ret.toString());

    return ret;
  }

  Future<dynamic> listChatMsgsOnce(String transId) async {
    print("listChatMsgsOnce");
    await _iniFirebase();
    var msgsRef = FirebaseDatabase.instance.ref("/akichats/" + transId);
    //var ret = await msgsRef.child(transId).child("msgs").get();
    var event = await msgsRef.once();
    var ret = event.snapshot.value;

    print("once: " + ret.toString());

    return ret;
  }

  Future<void> postChatMsg(String transId, String uuid, String msg) async {
    // setState(() {
    //   this._isLoading = true;
    // });
    //String jsonPost = "{/""transaction-id/"": { /""" + transId + "/"": { /""msgs/"": [ { /""msgBy/"": ""/" + uuid + "/"", /""msgText/"": /""" + msg + "/"" } ] } } }";
    //String jsonObj = '{"msgs": [ { "msgBy": "${uuid}", "msgText": "${msg}"} ] }';// ''{ """msgs""": [ { /""msgBy/"": ""/" + uuid + "/"", /""msgText/"": /""" + msg + "/"" } ] }";
    String jsonObj = '{ "msgBy": "${uuid}", "msgText": "${msg}"}';// ''{ """msgs""": [ { /""msgBy/"": ""/" + uuid + "/"", /""msgText/"": /""" + msg + "/"" } ] }";

    await _iniFirebase();
    var chatRef = FirebaseDatabase.instance.ref("akichats");
    //await chatRef.child(transId).child("msgs").set(jsonObj);

    // await chatRef.child(transId).child("msgs").child("msgBy").set(uuid);
    // await chatRef.child(transId).child("msgs").child("msgText").set(msg);

    await chatRef.child(transId).child("msgs/msgBy/").set(uuid);
    await chatRef.child(transId).child("msgs/msgText/").set(msg);

        //   .then((value) {
      // _getInfoFromBack().then((value) {
      //   setState(() {
      //     this._isLoading = false;
      //   });
  }
  //
  // Future<List<ChatMessages>> getAllByTransIdOnce(String transId) async {
  //   //https://ec3digrepo-default-rtdb.firebaseio.com/
  //   await _iniFirebase();
  //   await _fbInstance!.collection('akichats').where('transaction-id', isEqualTo: transId).get();
  //
  //   // CollectionReference coll = _fbInstance!.collection(col);
  //   // DocumentSnapshot snapshot = await coll.doc(doc).get();
  //   // var data = snapshot.data() as Map;
  //   // return data[subKey] as String;
  //   //
  //   //
  //   // final ref = _fbInstance!.instance.ref();
  //   //
  //   //
  //   //
  //   // String url = 'https://poraki.hasura.app/api/rest/ofertasfavperuserkeys/' + _loginController.usuGuid.toString();
  //   // print('OfertasFavs.getAll() - ' + url.toString());
  //   // var response = await get(url, headers: Constants.headers);
  //   // if (response.hasError) throw 'Ocorreu um erro em OfertaFav.getAll()';
  //   // return (response.body['OfertasFavs'] as List)
  //   //     .map((ofertafav) => OfertasFavs.fromJson(ofertafav))
  //   //     .toList();
  //
  //   final event = await ref.once(DatabaseEventType.value);
  //   final username = event.snapshot.value?.username ?? 'Anonymous';
  //   }
  // }
  //
  // Future<List<ChatMessages>> getAllListen() async {
  //   String url = 'https://poraki.hasura.app/api/rest/ofertasfavperuserkeys/' + _loginController.usuGuid.toString();
  //   print('OfertasFavs.getAll() - ' + url.toString());
  //   var response = await get(url, headers: Constants.headers);
  //   if (response.hasError) throw 'Ocorreu um erro em OfertaFav.getAll()';
  //   return (response.body['OfertasFavs'] as List)
  //       .map((ofertafav) => OfertasFavs.fromJson(ofertafav))
  //       .toList();
  //
  //
  //   final snapshot = await ref.child('users/$userId').get();
  //   if (snapshot.exists) {
  //     print(snapshot.value);
  //   } else {
  //     print('No data available.');
  //   }
  // }

}