import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/evento.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../auth/login/login_controller.dart';

class EventController extends GetxController {
  List<Evento> eventos = [];
  bool isLoading = false;
  final LoginController _loginController = Get.find();
  final TextEditingController? txtEventoNome = TextEditingController();
  final TextEditingController? txtEventoData = TextEditingController();
  // final TextEditingController? txtEventoHora = TextEditingController();
  final TextEditingController? txtEventoLocal = TextEditingController();
  final TextEditingController? txtEventoEndereco = TextEditingController();
  final TextEditingController? txtEventoDetalhes = TextEditingController();
  final TextFormField? txtData = TextFormField();
  String valEventoHora = '';

  @override
  void onInit() async {
    super.onInit();
  }

  Future<void> carregaEventos() async {
    print('carregaEventos regiao: ${_loginController.cloudId}');
    final FirebaseFirestore? fbInstance = _loginController.fbInstance;
    eventos.clear();
    await fbInstance!
        .collection("akievents")
        .doc(_loginController.cloudId)
        .collection("eventos")
        .get()
        .then((value) => value.docs.forEach((element) {
              eventos.add(Evento.fromJson(element.data()));
            }));
  }

  Future<String> novoEvento() async {
    var eventoGuid = Uuid().v4();
    try {
      _changeLoading(true);
      var evt = new Evento(eventoGuid, txtEventoNome!.text.toString(),
          //txtEventoData!.text.toString(),
          DateTime.now(),
          valEventoHora, txtEventoLocal!.text.toString(), txtEventoEndereco!.text.toString(), txtEventoDetalhes!.text.toString(),
          //EventoUID, EventoPor
        '',''
      );
      await _loginController.fbInstance!.collection("akievents").doc(_loginController.cloudId).collection("eventos").doc().set(evt.toJson());
    } catch (e) {
      print('Erro no novoEvento() controller ${e.toString()}');
    } finally {
      _changeLoading(false);
    }

    return eventoGuid.toString();
  }

  Future<void> apagaEvento() async {
    try {
      _changeLoading(true);
    } catch (e) {
      print('Erro no apagaEvento() controller ${e.toString()}');
    } finally {
      _changeLoading(false);
    }
  }

  void _changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}
