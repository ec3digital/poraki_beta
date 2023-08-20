import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import 'package:poraki/app/data/repositories/store_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:uuid/uuid.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class StoreController extends GetxController {
  StoreRepository storeRepo = StoreRepository();
  bool isLoading = false;
  // final formKey = GlobalKey<FormState>();
  LoginController _login = Get.find();
  final MaskedTextController txtLojaCEP =
      MaskedTextController(mask: '00000-000');
  final TextEditingController txtLojaLogra = TextEditingController();
  final TextEditingController txtLojaNumero = TextEditingController();
  final TextEditingController? txtLojaCompl = TextEditingController();
  final TextEditingController txtLojaNome = TextEditingController();
  final TextEditingController txtLojaSlogan = TextEditingController();
  final TextEditingController txtLojaCNPJ = TextEditingController();
  final TextEditingController txtLojaRazao = TextEditingController();
  final TextEditingController txtOutroCupom = TextEditingController();
  final TextEditingController txtPercCupom = TextEditingController();
  final TextEditingController txtLojaWhatsapp = TextEditingController();

  String? lojaGuid;
  //List<Lojas> lojas = [];
  Lojas? loja;

  Future<void> carregaLojas() async {
    _login.listLojas.clear();
    await _login.fbInstance!
        .collection("akilojas")
        .doc("eyCv21RfaURoMn0SUndCg6LPyJP2")
        .collection("Lojas")
        .get()
        .then((value) => value.docs.forEach((element) {
              _login.listLojas.add(Lojas.fromJson(element.data()));
            }));

    // try {
    //   _changeLoading(true);
    //   var lojasTemp = await storeRepo.getAllStores(_login.usuGuid.toString());
    //   print('lojasTemp: ' + lojasTemp.length.toString());
    //   lojas = lojasTemp;
    // } catch (e) {
    //   print('Erro no carregaLojas() controller ${e.toString()}');
    // } finally {
    //   _changeLoading(false);
    // }
  }

  void _changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<void> carregaLoja(String? guid) async {
    try {
      _changeLoading(true);
      if (guid != "")
        loja = _login.listLojas
            .where((store) => store.LojaGUID == guid)
            .first; //1await storeRepo.getStore(guid!);

      txtLojaCEP.text = loja!.LojaCEP.toString();
      txtLojaCNPJ.text = loja!.LojaCNPJ.toString();
      txtLojaNome.text = loja!.LojaNome.toString();
      txtLojaRazao.text = loja!.LojaRazao.toString();
      txtLojaSlogan.text = loja!.LojaSlogan.toString();
      txtLojaLogra.text = loja!.LojaLogra.toString();
      txtLojaNumero.text = loja!.LojaNumero.toString();
      txtLojaCompl?.text = loja!.LojaCompl.toString();
      txtLojaWhatsapp.text = loja!.LojaWhatsapp.toString();
      //txtOutroCupom.text = loja!
    } catch (e) {
      print('Erro no carregaLoja() controller ${e.toString()}');
    } finally {
      _changeLoading(false);
    }
  }

  void bindLoja() async {
    txtLojaCEP.text = loja!.LojaCEP == null ? "" : loja!.LojaCEP.toString();
    txtLojaCNPJ.text = loja!.LojaCNPJ == null ? "" : loja!.LojaCNPJ.toString();
    txtLojaNome.text = loja!.LojaNome == null ? "" : loja!.LojaNome.toString();
    txtLojaRazao.text =
        loja!.LojaRazao == null ? "" : loja!.LojaRazao.toString();
    txtLojaSlogan.text =
        loja!.LojaSlogan == null ? "" : loja!.LojaSlogan.toString();
    txtLojaLogra.text =
        loja!.LojaLogra == null ? "" : loja!.LojaLogra.toString();
    txtLojaNumero.text =
        loja!.LojaNumero == null ? "" : loja!.LojaNumero.toString();
    txtLojaCompl?.text =
        loja!.LojaCompl == null ? "" : loja!.LojaCompl.toString();
    txtLojaWhatsapp.text = loja!.LojaWhatsapp.toString();
  }

  void emptyLoja() {
    loja = null;
    txtLojaCEP.text = "";
    txtLojaCNPJ.text = "";
    txtLojaNome.text = "";
    txtLojaRazao.text = "";
    txtLojaSlogan.text = "";
    txtLojaLogra.text = "";
    txtLojaNumero.text = "";
    txtLojaCompl?.text = "";
    txtOutroCupom.text = "";
    txtPercCupom.text = "";
    txtLojaWhatsapp.text = "";
    this.refresh();
  }

  Future<String> saveLoja() async {
    Lojas? persistLoja;
    String resp = '';

    persistLoja = new Lojas(
        Timestamp.fromDate(DateTime.now()).toDate(),
        '', // loja!.LojaTemplateChave,
        txtLojaNome.text.trimRight(),
        txtLojaCEP.text.trimRight(),
        txtLojaSlogan.text.trimRight(),
        loja == null ? null : loja!.LojaGUID.toString(),
        _login.usuGuid,
        txtLojaCNPJ.text.trimRight(),
        txtLojaRazao.text.trimRight(),
        '', // loja!.Categorias,
        '', // loja!.LojaConfigs,
        txtLojaLogra.text.trimRight(),
        txtLojaNumero.text.trimRight(),
        txtLojaCompl!.text.trimRight(),
      txtLojaWhatsapp.text.trimRight(),
    );

    if (persistLoja.LojaGUID == null) {
      persistLoja.LojaGUID = Uuid().v4();
      resp = await storeRepo.postStore(persistLoja);

      // var jsonResp = jsonDecode(resp);
      // var strGuid = jsonResp['insert_Lojas_one']['LojaGUID'];

    } else {
      await storeRepo.putStore(persistLoja);
      resp = loja!.LojaGUID.toString();
    }

    await _login.loadStoresData();
    return persistLoja.LojaGUID.toString();
  }

  Future<void> apagaLoja(Lojas? loja) async {
    if(loja != null) {
      await storeRepo.deleteStore(loja);
      await _login.loadStoresData();

      // desativa as ofertas da Loja
      var offerRepo = new OfferRepository();
      await offerRepo.deleteOfferByStore(loja.LojaGUID.toString());
    }
  }

  Future<Lojas> retornaLoja(String lojaGuid) async {
    return await storeRepo.getStore(lojaGuid);
  }

}
