
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class fbPorakiService {

  //FirebaseFirestore? _fbInstance;
  fbPorakiService();
  late String Termos = "Termos";
  late String AppAviso;
  late String ParamValue;
  late String DicValue;

  // void onInit() async {
  //   _strTermos = "";
  //   _strAppAviso = "";
  //   _strParamValue = "";
  //   _strDicValue = "";
  //   _fbInstance = FirebaseFirestore.instance;
  //   print('oninit fb');
  //   //_fbInstance =  new FirebaseFirestore();
  // }

  // Future<String> _getTermosAync() async {
  //   String termos = "";
  //   await _getTermosFromFirebase().then((snapshot) => termos = snapshot.data()!.values.last.toString());
  //   print(termos);
  //   return termos;
  // }

  String getTermos() {
    _getTermosFromFirebase().then((value) => null);

    return Termos;
    // //_iniFirebase();
    // //await Firebase.initializeApp();
    // //late String ret;
    //
    // var docSnapshot = await FirebaseFirestore.instance.collection('akitermos').doc('termos').get();
    // if (docSnapshot.exists) {
    //   Map<String, dynamic>? data = docSnapshot.data();
    //   return data?['pt-br']; // <-- The value you want to retrieve.
    //   // Call setState if needed.
    // }
    //
    // //return ret;
    //
    // //var data = snapshot.data() as Map;
    // //_strTermos = data['pt-br'] as String;
    // //DocumentSnapshot snapshot = (await _getTermosFromFirebase()) as DocumentSnapshot;
    // //return snapshot.data()!['pt-br'];
    // //Map<String, dynamic> data = snapshot.data().map((key, value) => null);
    // //return snapshot.data()!.entries.first.value.toString();
    // //var data = getTermosFromFirebase().data() as Map;
    //
    // //return getTermosFromFirebase().asStream().first.toString() ;//.then((snapshot) => termos = snapshot.data()!.values.last.toString());
    // //return _getTermosAync() as String;
  }

  String getAppAviso() {
    getAppAvisoFromFirebase();
    return AppAviso;
  }

  String getParamValue(String Key, String SubKey) {
    getParamValueFromFirebase(Key, SubKey);
    return ParamValue;
  }

  String getDicValue(String Key) {
    getDicValueFromFirebase(Key);
    return DicValue;
  }

  _iniFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> _getTermosFromFirebase() async {
    FirebaseFirestore _fbInstance = FirebaseFirestore.instance;
    CollectionReference coll = _fbInstance.collection('akitermos');
    var result = await coll.get();
    print("_getTermosFromFirebase" + result.docs.first['ptbr']);
    Future.value(Termos = result.docs.first['ptbr']);
    //_strTermos = result.docs.first['ptbr'];
    // DocumentSnapshot snapshot = await coll.doc('termos').get();
    // var data = snapshot.data() as Map;
    // _strTermos = data['ptbr'] as String;

    //
    // DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('akitermos').doc('termos').get(); //.then((snapshot) => _strTermos = snapshot.data()!.values.first.toString());
    // var data = snapshot.data() as Map;
    // setState(() {}
    // )
    // _strTermos = data as List; //['ptbr'];
  }

  //
  // Future<Stream<DocumentSnapshot>> _getTermosFromFirebase() async {
  //   _strTermos = "";
  //   await Firebase.initializeApp();
  //   return await FirebaseFirestore.instance.collection('akitermos').doc('termos').snapshots();
  //
  //   // FirebaseFirestore _fbInstance = FirebaseFirestore.instance;
  //   // print('getTermosFromFirebase');
  //   // CollectionReference coll = _fbInstance.collection('akitermos');
  //   // DocumentSnapshot snapshot = await coll.doc('termos').get();
  //   // var data = snapshot.data() as Map;
  //   // _strTermos = data['pt-br'] as String;
  //   // print('data length: ' + data.length.toString());
  //   // print('_strTermos: ' + _strTermos);
  // }

  Future<void> getAppAvisoFromFirebase() async {
    // _fbInstance = FirebaseFirestore.instance;
    FirebaseFirestore _fbInstance = FirebaseFirestore.instance;
    CollectionReference coll = _fbInstance.collection('akiavisos');
    DocumentSnapshot snapshot = await coll.doc('avisos').get();
    var data = snapshot.data() as Map;
    Termos = data['pt-br'];
  }

  Future<void> getDicValueFromFirebase(String key) async {
    // _fbInstance = FirebaseFirestore.instance;
    FirebaseFirestore _fbInstance = FirebaseFirestore.instance;
    CollectionReference coll = _fbInstance.collection('akidic');
    DocumentSnapshot snapshot = await coll.doc(key).get();
    var data = snapshot.data() as Map;
    DicValue = data['pt-br'] as String;
  }

  Future<void> getParamValueFromFirebase(String key, String subKey) async {
    // _fbInstance = FirebaseFirestore.instance;
    FirebaseFirestore _fbInstance = FirebaseFirestore.instance;
    CollectionReference coll = _fbInstance.collection('akiparams');
    DocumentSnapshot snapshot = await coll.doc(key).get();
    var data = snapshot.data() as Map;
    ParamValue = data[subKey] as String;
  }

}