import 'dart:convert';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/repositories/store_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class StoreController extends GetxController {
  StoreRepository storeRepo = StoreRepository();
  bool isLoading = false;
  // final formKey = GlobalKey<FormState>();
  LoginController _login = Get.find();
  final MaskedTextController txtLojaCEP = MaskedTextController(mask: '00000-000');
  final TextEditingController txtLojaLogra = TextEditingController();
  final TextEditingController txtLojaNumero = TextEditingController();
  final TextEditingController? txtLojaCompl = TextEditingController();
  final TextEditingController txtLojaNome = TextEditingController();
  final TextEditingController txtLojaSlogan = TextEditingController();
  final TextEditingController txtLojaCNPJ = TextEditingController();
  final TextEditingController txtLojaRazao = TextEditingController();
  final TextEditingController txtOutroCupom = TextEditingController();
  final TextEditingController txtPercCupom = TextEditingController();

  String? lojaGuid;
  List<Lojas> lojas = [];
  Lojas? loja;

  Future<void> carregaLojas() async {
    try {
      _changeLoading(true);
      var lojasTemp = await storeRepo.getAllStores(_login.usuGuid.toString());
      print('lojasTemp: ' + lojasTemp.length.toString());
      lojas = lojasTemp;
    } catch (e) {
      print('Erro no carregaLojas() controller ${e.toString()}');
    } finally {
      _changeLoading(false);
    }
  }

  void _changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Future<void> carregaLoja(String? guid) async {
    try {
      _changeLoading(true);
      if (guid != "") loja = await storeRepo.getStore(guid!);

      txtLojaCEP.text = loja!.LojaCEP.toString();
      txtLojaCNPJ.text = loja!.LojaCNPJ.toString();
      txtLojaNome.text = loja!.LojaNome.toString();
      txtLojaRazao.text = loja!.LojaRazao.toString();
      txtLojaSlogan.text = loja!.LojaSlogan.toString();
      txtLojaLogra.text = loja!.LojaLogra.toString();
      txtLojaNumero.text = loja!.LojaNumero.toString();
      txtLojaCompl?.text = loja!.LojaCompl.toString();
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
    txtLojaRazao.text = loja!.LojaRazao == null ? "" : loja!.LojaRazao.toString();
    txtLojaSlogan.text = loja!.LojaSlogan == null ? "" : loja!.LojaSlogan.toString();
    txtLojaLogra.text = loja!.LojaLogra == null ? "" : loja!.LojaLogra.toString();
    txtLojaNumero.text = loja!.LojaNumero == null ? "" : loja!.LojaNumero.toString();
    txtLojaCompl?.text = loja!.LojaCompl == null ? "" : loja!.LojaCompl.toString();
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
    this.refresh();
  }

  Future<String> saveLoja() async {
    Lojas? persistLoja;
    if(loja != null)
      persistLoja = new Lojas(loja!.LojaAtivaDesde!, loja!.LojaTemplateChave, txtLojaNome.text.trimRight(),
        txtLojaCEP.text.trimRight(), txtLojaSlogan.text.trimRight(), loja!.LojaGUID, _login.usuGuid, txtLojaCNPJ.text.trimRight(),
        txtLojaRazao.text.trimRight(), loja!.Categorias, loja!.LojaConfigs, txtLojaLogra.text.trimRight(),
        txtLojaNumero.text.trimRight(), txtLojaCompl!.text.trimRight());
    else
      persistLoja = new Lojas(null, null, txtLojaNome.text.trimRight(),
          txtLojaCEP.text.trimRight(), txtLojaSlogan.text.trimRight(), null, _login.usuGuid, txtLojaCNPJ.text.trimRight(),
          txtLojaRazao.text.trimRight(), null, null, txtLojaLogra.text.trimRight(),
          txtLojaNumero.text.trimRight(), txtLojaCompl!.text.trimRight());

    String resp;
    if (persistLoja.LojaGUID == null) {
      resp = await storeRepo.postStore(persistLoja);

      var jsonResp = jsonDecode(resp);
      var strGuid = jsonResp['insert_Lojas_one']['LojaGUID'];

      resp = strGuid;
    } else {
      await storeRepo.putStore(persistLoja);
      resp = loja!.LojaGUID.toString();
    }

    await carregaLojas();
    return resp;
  }

}
