import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/models/sql/sqlCore.dart';
import 'package:poraki/app/data/repositories/address_repository.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'package:poraki/app/services/fbporaki_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_core_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';
import '../../../data/repositories/login_repository.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController mailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final LoginRepository loginRepository = LoginRepository();

  get obscurePassword => _obscurePassword;

  List<sqlCore> listCore = [];
  List<sqlCore> listCoreCep = [];
  List<Enderecos> listEnderecos = [];
  bool _obscurePassword = false;
  String? usuCep;
  String? usuNome;
  String? usuEmail;
  String? usuGuid;
  // TODO: implementar baseUrl + headers por CEP
  // String? baseUrl;
  // Map<String, String>? headers;

  void changeCheckBox(bool newObscurePassword) {
    _obscurePassword = newObscurePassword;
    update();
  }

  // carrega dados do usuario
  Future<void> loadUserData() async {
    print('loadUserData');
    usuGuid = 'eyCv21RfaURoMn0SUndCg6LPyJP2';

    await _getCep();
    List<Map<String, dynamic>>? listUser;
    var sqlSvc = new sqlPorakiLoginService();
    listUser = await sqlSvc.buscaUsuDados();
    for (var u in listUser) //{
      listUser.forEach((element) {
        usuNome = element["usuNome"].toString();
      });
  }

  // carrega dados do usuario
  Future<void> loadAddressData() async {
    print('loadAddressData');
    var addressSvc = new AddressRepository();
    listEnderecos = await addressSvc.getAllAddresses();
    // for (var u in listUser) //{
    //   listUser.forEach((element) {
    //     usuNome = element["usuNome"].toString();
    //   });
  }

  // atualiza tabela core local com a nuvem
  Future<void> runCore() async {
    // pega os valores da tabela nuvem
    var listCoreTemp = [];
    var coreFB = await fbPorakiService().getListFromFirebase("akicore", "core");
    listCoreTemp = await sqlPorakiCoreService().buscaTodosValores();

    var coreFBcep =
        await fbPorakiService().getListFromFirebase("akicore", "057");
    listCoreCep = await sqlPorakiCoreService().buscaTodosValoresCep();
    if (coreFBcep.isNotEmpty) {
      // reseta tabela core local cep
      await sqlPorakiCoreService().resetaTabelaCep();
      // verifica tabela core local cep
      await sqlPorakiCoreService().verificaTabelaCep();
      // insere os valores iniciais cep
      await sqlPorakiCoreService().valoresIniciaisCep();

      // pega os valores da tabela local
      var coreSqlCep = listCoreCep;

      //faz o iteracao da tabela local contra a nuvem pra nao causar erro caso haja mais chaves na nuvem
      coreSqlCep.forEach((coreItem) {
        coreFBcep.forEach((key, value) {
        //   print(key);
        //   var coreSqlUpdate =
        //       coreSqlCep.where((coreItem) => coreItem.coreChave == key).first;
        //   if (coreSqlUpdate.coreValor != value) {
        //     coreSqlUpdate.coreValor = value.toString();
        //     sqlPorakiCoreService().atualizaCoreCep(coreSqlUpdate);
        //   }
        var coreFBcepTemp = coreFB.entries.where((element) => element.key == coreItem.coreChave).first;
        if(coreItem.coreValor != coreFBcepTemp.value) {
          coreItem.coreValor = coreFBcepTemp.value;

          sqlPorakiCoreService().atualizaCoreCep(coreItem);
        }
        });
      });

      // atualiza lista de params core
      listCoreCep = await sqlPorakiCoreService().buscaTodosValoresCep();
      // print('listCoreCep final qtd: ' + listCoreCep.length.toString());
    }

    // se chegaram dados da nuvem
    if (coreFB.isNotEmpty) {
      // coreFB.forEach((key, value) {print('key: ' + key + ' / value: ' + value);});
      // reseta tabela core local
      await sqlPorakiCoreService().resetaTabela();
      // verifica tabela core local
      await sqlPorakiCoreService().verificaTabela();
      // insere os valores iniciais
      await sqlPorakiCoreService().valoresIniciais();

      // pega os valores da tabela local
      var coreSql = listCoreTemp;
      // print('coreSql new qtd: ' + coreSql.length.toString());

      //faz o iteracao da tabela local contra a nuvem pra nao causar erro caso haja mais chaves na nuvem
      coreSql.forEach((coreItem) {
        print('coreItem: ' + coreItem.coreChave);
        var coreFBtemp = coreFB.entries.where((element) => element.key == coreItem.coreChave).first;
        if(coreItem.coreValor != coreFBtemp.value) {
          coreItem.coreValor = coreFBtemp.value;

          sqlPorakiCoreService().atualizaCore(coreItem);
        }
      });

      // atualiza lista de params core
      listCore = await sqlPorakiCoreService().buscaTodosValores();
      print('coreSql final qtd: ' + listCore.length.toString());
    }
  }

  Color colorFromHex(String? hexColor) {
    final hexCode = hexColor!.replaceAll('#', '');
    return Color(int.parse(hexCode));
  }

  _getCep() async {
    if (usuCep == null) {
      var _addressController = new AddressController();
      usuCep = await _addressController.getCepAtualCloud();
    }
    print('usuCep atual: ' + usuCep.toString());
  }

  // valida o login
  void doLogin(BuildContext context) async {
    // if (formKey.currentState!.validate()) {
    //   loginRepository.userLogin(
    //     LoginModel(
    //       mail: mailInputController.text.removeAllWhitespace,
    //       password: passwordInputController.text.removeAllWhitespace,
    //       keepOn: false,
    //       name: '',
    //     ),
    //   );

    // salva usuario no hive, cria instancia do hive e abre a box
    //new hivePorakiUserService().SetUserEmail(mailInputController.text.removeAllWhitespace);

    await loadUserData();
    await runCore();

    // redireciona para a home de ofertas
    Get.toNamed(AppRoutes.offer);
    // } else {
    //   print("invalido");
    // }

    //compara qtd de pedidos fechados com a nuvem e atualiza se for o caso

    //executa comandos na base local
  }
}
