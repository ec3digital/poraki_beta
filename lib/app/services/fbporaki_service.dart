
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;

class fbPorakiService {
  fbPorakiService();

  // String? ParamValue;
  // String? DicValue;
  FirebaseFirestore? _fbInstance;
  String? cepAtual;


  _iniFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    _fbInstance = FirebaseFirestore.instance;
  }

  _getCep() async {
    if(cepAtual!.isEmpty)
      {
        var _addressController = new AddressController();
        cepAtual = await _addressController.getCepAtualLocal();
        print('cep atual sql:' + cepAtual!);
      }
  }

  _getCepCloud() async {
    if(cepAtual!.isEmpty)
    {
      var _addressController = new AddressController();
      cepAtual = await _addressController.getCepAtualCloud();
      print('cep atual cloud:' + cepAtual!);
    }
  }


  Future<String> getValueFromFirebase(String col, String doc, String subKey) async {
    await _iniFirebase();
    CollectionReference coll = _fbInstance!.collection(col);
    DocumentSnapshot snapshot = await coll.doc(doc).get();
    var data = snapshot.data() as Map;
    return data[subKey] as String;
  }

  Future<String> getValueFromFirebaseCep(String col, String subKey) async {
    await _iniFirebase();
    await _getCep(); //atualiza o cep

    if(cepAtual!.isEmpty)
      return "000";

    CollectionReference coll = _fbInstance!.collection(col);
    DocumentSnapshot snapshot = await coll.doc(cepAtual).get();
    var data = snapshot.data() as Map;
    return data[subKey] as String;
  }

  Future<Map<String, dynamic>> getListFromFirebase(String col, String doc) async {
    await _iniFirebase();
    CollectionReference coll = _fbInstance!.collection(col);
    DocumentSnapshot snapshot = await coll.doc(doc).get();

    // var data = snapshot.data() as Map;

    // var data = new Map<String, dynamic>.from(snapshot);

    // final _data = List<dynamic>.from(data.map<dynamic>((dynamic item) => item,),);

    // List<String, dynamic> ret = [];
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    // data.forEach((key, value) { });

    // InternalLinkedHashMap<String, dynamic> invalidMap;
    // final validMap = json.decode(json.encode(invalidMap)) as Map<String, dynamic>;

    print('core data: qtd ' + data.length.toString());
    return data;
  }

  Future<List<Map<dynamic, dynamic>>> getListFromFirebaseCep(String col) async {
    await _iniFirebase();
    await _getCep(); //atualiza o cep

    await _iniFirebase();
    CollectionReference coll = _fbInstance!.collection(col);
    DocumentSnapshot snapshot = await coll.doc(cepAtual).get();
    var data = snapshot.data() as Map;
    return data as List<Map<dynamic, dynamic>>;
  }

  // TODO: fazer tudo por child
  Future<dynamic> postNotif(String uuid, String notifType, String notifContent) async {
    Uri urlAkiNotifs = Uri.https("ec3digrepo-default-rtdb.firebaseio.com", "/akinotif.json");
    String jsonPost = "{'uuid': { '" + uuid + "': { 'notifs': [ { 'notifType': '" + notifType + "', 'notifContent': '" + notifContent + "' } ] } } }";

    var resp = await http.post(urlAkiNotifs, body: jsonPost);
    return resp;
  }

  Future<dynamic> deleteNotif(String uuid, String notifType, String notifContent) async {
    Uri urlAkiNotifs = Uri.https("ec3digrepo-default-rtdb.firebaseio.com", "/akinotif.json");
    String jsonPost = "{'uuid': { '" + uuid + "': { 'notifs': [ { 'notifType': '" + notifType + "', 'notifContent': '" + notifContent + "' } ] } } }";

    var resp = await http.delete(urlAkiNotifs, body: jsonPost);
    return resp;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getFbTransMsgs(String transId, String doc) async {
    await _iniFirebase();
    CollectionReference coll = _fbInstance!.collection("akitransactions");
    var snapshot = coll.doc(transId).collection("chat").orderBy("sentIn").snapshots();

    // var data = snapshot.data() as Map;

    // var data = new Map<String, dynamic>.from(snapshot);

    // final _data = List<dynamic>.from(data.map<dynamic>((dynamic item) => item,),);

    // List<String, dynamic> ret = [];
    //await snapshot.forEach((element) {print(element.docs[0].data().toString());}); //  as Map<String, dynamic>;
    //print(data);
    // data.forEach((key, value) { });

    // InternalLinkedHashMap<String, dynamic> invalidMap;
    // final validMap = json.decode(json.encode(invalidMap)) as Map<String, dynamic>;

    //print('chat data: qtd ' + data.length.toString());
    return snapshot;
  }


  // String getParamValue(String Key, String SubKey) {
  //   getParamValueFromFirebase(Key, SubKey);
  //   return ParamValue!;
  // }
  //
  // String getDicValue(String Key) {
  //   getDicValueFromFirebase(Key);
  //   return DicValue!;
  // }
  //
  // Future<void> getDicValueFromFirebase(String key) async {
  //   await _iniFirebase();
  //   CollectionReference coll = _fbInstance!.collection('akidic');
  //   DocumentSnapshot snapshot = await coll.doc(key).get();
  //   var data = snapshot.data() as Map;
  //   DicValue = data['pt-br'] as String;
  // }
  //
  // Future<void> getParamValueFromFirebase(String key, String subKey) async {
  //   await _iniFirebase();
  //   CollectionReference coll = _fbInstance!.collection('akiparams');
  //   DocumentSnapshot snapshot = await coll.doc(key).get();
  //   var data = snapshot.data() as Map;
  //   ParamValue = data[subKey] as String;
  // }


}