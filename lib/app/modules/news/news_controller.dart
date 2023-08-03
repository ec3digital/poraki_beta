import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/noticias.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/login/login_controller.dart';

class NewsController extends GetxController {
  List<Noticia> noticias = [];
  bool isLoading = false;
  final LoginController _loginController = Get.find();
  // late FirebaseFirestore? fbInstance;

  @override
  void onInit() async {
    // await carregaNoticias();
    super.onInit();
  }

  Future<void> carregaNoticias() async {
    if (_loginController.usuCep!.length >= 3) {
      print('carregaNoticias cep: ${_loginController.usuCep!.substring(0, 3)}');
      final FirebaseFirestore? fbInstance = _loginController.fbInstance;
      noticias.clear();
      //await fbInstance!.collection("akinews").doc('057').collection("news").get().then((value) => value.docs.forEach((element) { print(element.data()); }));
      await fbInstance!
          .collection("akinews")
          .doc(_loginController.usuCep!.substring(0, 3))
          .collection("news")
          .get()
          .then((value) => value.docs.forEach((element) {
                noticias.add(Noticia.fromJson(element.data()));
              }));
    }
  }

  Future<void> carregaNoticiasRealtime() async {
    try {
      _changeLoading(true);
      noticias.clear();
      var x = FirebaseDatabase.instance
          .ref('akinews/057/'); //.orderByChild('metrics/views');

      DatabaseEvent event = await x.once();
      final data = Map<String, Object?>.from(
          event.snapshot.value! as Map<Object?, Object?>);
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
