import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_address_service.dart';

class AddressController extends GetxController {
  // enderecoGuid;
  // final String  usuEmail;
  // final String  usuGuid;
  final MaskedTextController    txtCEP            = MaskedTextController(mask: '00000-000');
  final TextEditingController   txtEnderecoLogra  = TextEditingController();
  final TextEditingController   txtEnderecoNumero = TextEditingController();
  final TextEditingController?  txtEnderecoCompl  = TextEditingController();
  final TextEditingController   txtEnderecoTipo   = TextEditingController();
  // final int     txtEnderecoAtual;
  // final String? txtEnderecoUltData;
  // final String? txtEnderecoDesde;

  // AddressRepository addressRepository = AddressRepository();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  List<sqlEndereco> enderecos = [];
  late sqlEndereco enderecoSingle;

  // Future<void> getAllCategories() async {
  //   try {
  //     changeLoading(true);
  //     categorias = await categoriesRepository.getAllCategories();
  //   } catch (e) {
  //     print('Erro no getAllCategories() controller ${e.toString()}');
  //   } finally {
  //     changeLoading(false);
  //   }
  // }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }


  // @override
  // void onInit() async {
  //   await carregaUsuario();
  //   super.onInit();
  // }

  Future<void> carregaEnderecos() async {
    print('carregaEnderecos');

    var lista = await sqlPorakiAddressService().buscaEnderecos(false);
    lista.forEach((item) {
      var endereco = new sqlEndereco(
        item.enderecoGuid.toString(),
        item.usuEmail.toString(),
        item.enderecoGuid.toString(),
        item.enderecoCEP.toString(),
        item.enderecoLogra.toString(),
        item.enderecoNumero.toString(),
        item.enderecoCompl.toString(),
        item.enderecoTipo.toString(),
        item.enderecoAtual,
        item.enderecoUltData.toString(),
        //item.enderecoDesde.toString(),
      );

      enderecos.add(endereco);
    });

  }

  Future<sqlEndereco> EnderecoAtual() async {
    print('carregaEnderecoAtual');

    var lista = await sqlPorakiAddressService().buscaEnderecos(true);
    late sqlEndereco endereco;
    lista.forEach((item) {
      endereco = new sqlEndereco(
        item.enderecoGuid.toString(),
        item.usuEmail.toString(),
        item.enderecoGuid.toString(),
        item.enderecoCEP.toString(),
        item.enderecoLogra.toString(),
        item.enderecoNumero.toString(),
        item.enderecoCompl.toString(),
        item.enderecoTipo.toString(),
        item.enderecoAtual,
        item.enderecoUltData.toString(),
        //item.enderecoDesde.toString(),
      );
    });

    return endereco;
  }

  Future<void> carregaEnderecoSingle(String enderecoGuid) async {
    print('carregaEnderecoSingle');

    var lista = await sqlPorakiAddressService().buscaEnderecoSingle(enderecoGuid);
    lista.forEach((item) {
      enderecoSingle = new sqlEndereco(
        item.enderecoGuid.toString(),
        item.usuEmail.toString(),
        item.enderecoGuid.toString(),
        item.enderecoCEP.toString(),
        item.enderecoLogra.toString(),
        item.enderecoNumero.toString(),
        item.enderecoCompl.toString(),
        item.enderecoTipo.toString(),
        item.enderecoAtual,
        item.enderecoUltData.toString(),
        //item.enderecoDesde.toString(),
      );
    });

    txtCEP.text = enderecoSingle.enderecoCEP;
    txtEnderecoLogra.text = enderecoSingle.enderecoLogra;
    txtEnderecoNumero.text = enderecoSingle.enderecoNumero;
    txtEnderecoCompl!.text = enderecoSingle.enderecoCompl!;
    txtEnderecoTipo.text = enderecoSingle.enderecoTipo;
  }

  Future<void> atualizaEndereco(sqlEndereco endereco) async {
    await sqlPorakiAddressService().updateEndereco(endereco);
    // await carregaUsuario();
  }

  Future<void> adicionaEndereco(sqlEndereco endereco) async {
    await sqlPorakiAddressService().insertEndereco(endereco);
    // await carregaUsuario();
  }

  Future<void> apagaEndereco(String enderecoGuid) async {
    await sqlPorakiAddressService().deleteEndereco(enderecoGuid);
    // await carregaUsuario();
  }

  Future<void> tornarEnderecoAtual(String enderecoGuid) async {
    await sqlPorakiAddressService().updateEnderecoAtual(enderecoGuid);
    // await carregaUsuario();
  }

}