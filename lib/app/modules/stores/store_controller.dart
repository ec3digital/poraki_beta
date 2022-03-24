import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/repositories/store_repository.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class StoreController extends GetxController {
  // enderecoGuid;
  // final String  usuEmail;
  // final String  usuGuid;
  final MaskedTextController txtLojaCEP = MaskedTextController(mask: '00000-000');
  final TextEditingController txtLojaNome = TextEditingController();
  final TextEditingController txtLojaSlogan = TextEditingController();
  final TextEditingController txtLojaCNPJ = TextEditingController();
  final TextEditingController txtLojaRazao = TextEditingController();
  // final int     txtEnderecoAtual;
  // final String? txtEnderecoUltData;
  // final String? txtEnderecoDesde;

  StoreRepository storeRepo = StoreRepository();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  LoginController _login = Get.find();

  List<Lojas> lojas = [];
  Lojas? loja;
  // late sqlEndereco enderecoSingle;

  Future<void> carregaLojas() async {
    try {
      changeLoading(true);
      lojas = await storeRepo.getAllStores(_login.usuGuid.toString());
    } catch (e) {
      print('Erro no carregaLojas() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  // @override
  // void onInit() async {
  //   await carregaUsuario();
  //   super.onInit();
  // }

  Future<void> carregaLoja(String guid) async {
    print('carregaLoja');

    try {
      changeLoading(true);
      loja = await storeRepo.getStore(guid);

      txtLojaCEP.text = loja!.LojaCEP.toString();
      txtLojaCNPJ.text = loja!.LojaCNPJ.toString();
      txtLojaNome.text = loja!.LojaNome.toString();
      txtLojaRazao.text = loja!.LojaRazao.toString();
      txtLojaSlogan.text = loja!.LojaSlogan.toString();

    } catch (e) {
      print('Erro no carregaLoja() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }


  // Future<void> atualizaLoja(sqlEndereco endereco) async {
  //   await sqlPorakiAddressService().updateEndereco(endereco);
  //   // await carregaUsuario();
  // }
  //
  // Future<void> adicionaLoja(sqlEndereco endereco) async {
  //   await sqlPorakiAddressService().insertEndereco(endereco);
  //   // await carregaUsuario();
  // }
  //
  // Future<void> apagaLoja(String enderecoGuid) async {
  //   await sqlPorakiAddressService().deleteEndereco(enderecoGuid);
  //   // await carregaUsuario();
  // }

}
