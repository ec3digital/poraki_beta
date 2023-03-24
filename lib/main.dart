import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:poraki/app/modules/auth/login/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poraki/app/modules/chats/chat_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app/modules/testes_widgets/testefb/testefb.dart';
import 'app/services/fbporaki_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await carregaListaRevendas();
  //await carregaListaCategorias();
  runApp(MyApp());
}


Future<void> carregaListaRevendas() async {
  FirebaseFirestore? _fbInstance;
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  _fbInstance = FirebaseFirestore.instance;
  //criar mapping de revendas e jogar o toList no mapping e depois iterar
  List<dynamic> revendas = [];
  await _fbInstance.collection("akirevendas").get().then((value) => value.docs.toList().first.data().values.forEach((element) {revendas.add(element);}));
  revendas.forEach((e) { print(e); });
}

Future<void> carregaListaCategorias() async {
  FirebaseFirestore? _fbInstance;
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  _fbInstance = FirebaseFirestore.instance;
  //criar mapping de revendas e jogar o toList no mapping e depois iterar
  List<dynamic> categs = [];
  await _fbInstance.collection("akicategs").doc("Categorias").collection("lista").get().then((value) => value.docs.forEach((element) { print(element.data()); }));
  //categs.forEach((e) { print(e); });
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PorAki',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate
      // ],
      // supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
