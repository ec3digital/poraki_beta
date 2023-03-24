import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:poraki/app/data/models/noticias.dart';
import 'package:poraki/app/data/repositories/news_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../data/models/enderecos.dart';
import '../../shared/constants/constants.dart';
import '../auth/login/login_controller.dart';

class NewsController extends GetxController {
  List<Noticia> noticias = [];
  bool isLoading = false;
  final LoginController _loginController = Get.find();
  late FirebaseFirestore? fbInstance;

  @override
  void onInit() async {
    super.onInit();

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    fbInstance = FirebaseFirestore.instance;
  }

  Future<void> carregaNoticias() async {
    print('carregaNoticias');
    noticias.clear();
    //await fbInstance!.collection("akinews").doc('057').collection("news").get().then((value) => value.docs.forEach((element) { print(element.data()); }));
    await fbInstance!.collection("akinews").doc(_loginController.usuCep!.substring(0,3)).collection("news").get().then((value) => value.docs.forEach((element) { noticias.add(Noticia.fromJson(element.data())); }));
  }

  Future<void> carregaNoticiasRealtime() async {
    try {
      _changeLoading(true);
      noticias.clear();
      var x = FirebaseDatabase.instance
          .ref('akinews/057/'); //.orderByChild('metrics/views');

      DatabaseEvent event = await x.once();
      final data = Map<String, Object?>.from(event.snapshot.value! as Map<Object?, Object?>);
      print(data.values);

      //TODO: fazer o laço onde cada value é uma noticia e adicionar a uma lista

      // Cancel any previously committed operations
      OnDisconnect onDisconnect = x.onDisconnect();
      await onDisconnect.cancel();
    } catch (e) {
      print('Erro no carregaNoticias() controller ${e.toString()}');
    } finally {
      _changeLoading(false);
    }
  }

  void _changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}
