import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class ChatMsgsService extends GetConnect {

  _iniFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  }

  Future<dynamic> listChatMsgsListen(String transId) async {
    print('listChatMsgsListen');
    await _iniFirebase();
    var msgsRef = FirebaseDatabase.instance.ref("/akichats/" + transId);
    late Object ret;
    msgsRef.onValue.listen((DatabaseEvent event) {
    ret = event.snapshot.value!;
    });

    print("listen: " + ret.toString());
    return ret;
  }

  Future<dynamic> listChatMsgsOnce(String transId) async {
    await _iniFirebase();
    var msgsRef = FirebaseDatabase.instance.ref("/akichats/" + transId);
    var event = await msgsRef.once();
    var ret = event.snapshot.value;

    print("once: " + ret.toString());
    return ret;
  }

  Future<void> postChatMsg(String transId, String uuid, String msg) async {
    // String jsonObj = '{ "msgBy": "${uuid}", "msgText": "${msg}"}';// ''{ """msgs""": [ { /""msgBy/"": ""/" + uuid + "/"", /""msgText/"": /""" + msg + "/"" } ] }";

    await _iniFirebase();
    var chatRef = FirebaseDatabase.instance.ref("akichats");
    await chatRef.child(transId).child("msgs/msgBy/").set(uuid);
    await chatRef.child(transId).child("msgs/msgText/").set(msg);
  }

}