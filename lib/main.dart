import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //runApp(testeCloud());
  //runApp(Card1());
  //runApp(TelaOfer());
  runApp(AppWidget());
  //final CollTermos _colltermos = Firebase.instance.collection("akitermos")
  //var listatermos = FirebaseFirestore.instance.collection("akitermos").snapshots(); //doc("es-mx").snapshots().toList();
  //print(listatermos.first);
}
