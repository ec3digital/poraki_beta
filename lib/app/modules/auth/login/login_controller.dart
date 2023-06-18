import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/models/revendas.dart';
import 'package:poraki/app/data/models/sql/sqlCore.dart';
import 'package:poraki/app/data/repositories/address_repository.dart';
import 'package:poraki/app/data/repositories/offerfav_repository.dart';
import 'package:poraki/app/data/repositories/store_repository.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'package:poraki/app/services/fbporaki_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_address_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_core_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';
import '../../../data/models/categorias.dart';
import '../../../data/repositories/login_repository.dart';
import '../../../routes/app_routes.dart';

class LoginController extends GetxController {
  final TextEditingController mailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  // final formKey = Get.key; // GlobalKey<FormState>();
  final LoginRepository loginRepository = LoginRepository();
  late FirebaseFirestore? fbInstance;
  final FirebaseAuth? auth = FirebaseAuth.instance;
  //final AddressController addressController = Get.find();

  get obscurePassword => _obscurePassword;

  //TODO: pegar os banners do firebase
  List<String> listBanners = [
    'http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/PORAKI-Banner-sm_default1.jpg',
  ];
  List<sqlCore> listCore = [];
  List<sqlCore> listCoreCep = [];
  List<Enderecos> listaEnderecos = [];
  List<Lojas> listLojas = [];
  List<OfertasFavs> ofertasFavs = [];
  List<Categorias> listaCategorias = [];
  List<Revendas> listaRevendas = [];
  List<String> listaRevendasNomes = [];
  bool _obscurePassword = false;
  bool refreshOfertasFavs = false;
  String? usuCep;
  String? usuNome;
  String? usuEmail;
  String? usuGuid;
  String? cloudId;
  // TODO: implementar baseUrl + headers por CEP
  // String? baseUrl;
  // Map<String, String>? headers;

  @override
  void onInit() async {
    super.onInit();

    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }

    fbInstance = FirebaseFirestore.instance;
  }

  void changeCheckBox(bool newObscurePassword) {
    _obscurePassword = newObscurePassword;
    update();
  }

  // atribui a variavel da nuvem
  Future<void> getCloudId() async {
    cloudId = '057';
  }

  // carrega dados do usuario
  Future<void> loadUserData() async {
    print('loadUserData');
    usuGuid = 'eyCv21RfaURoMn0SUndCg6LPyJP2';
    // usuEmail = 'danilojazz@gmail.com';

    //pega o cep local
    await _getCep();

    //apaga todos os ceps da tabela local e baixa tudo de novo da nuvem
    // await sqlPorakiAddressService().deleteEnderecos();
    // await sqlPorakiAddressService().buscaEnderecos(false);

    //pega o nome do usuario
    List<Map<String, dynamic>>? listUser;
    var sqlSvc = new sqlPorakiLoginService();
    listUser = await sqlSvc.buscaUsuDados();
    for (var u in listUser) //{
      listUser.forEach((element) {
        usuNome = element["usuNome"].toString();
      });
  }

  // carrega endereços do usuario
  Future<void> loadAddressData() async {
    listaEnderecos.clear();
    await fbInstance!
        .collection("akienderecos")
        .doc(auth!.currentUser!.uid)
        .collection("Enderecos")
        .get()
        .then((value) => value.docs.forEach((element) {
              listaEnderecos.add(Enderecos.fromJson(element.data()));
            }));

    // var tempEnderecos =
    // await fbPorakiService().getListFromFirebase("akienderecos", "eyCv21RfaURoMn0SUndCg6LPyJP2");
    // tempEnderecos.forEach((key, value) {
    //   print('endereço: ' + value);
    //   listEnderecos.add(value);
    // });

    // print(tempEnderecos.values);

    // var addressSvc = new AddressRepository();
    // listEnderecos = await addressSvc.getAllAddresses();
    // // for (var u in listUser) //{
    // //   listUser.forEach((element) {
    // //     usuNome = element["usuNome"].toString();
    // //   });
  }

  // carrega lojas do usuario
  Future<void> loadStoresData() async {
    listLojas.clear();
    await fbInstance!
        .collection("akilojas")
        .doc(auth!.currentUser!.uid)
        .collection("Lojas")
        .get()
        .then((value) => value.docs.forEach((element) {
              listLojas.add(Lojas.fromJson(element.data()));
            }));
  }

  Future<void> getCategories() async {
    listaCategorias.clear();
    await fbInstance!
        .collection("akicategs")
        .doc("Categorias")
        .collection("lista")
        .get()
        .then((value) => value.docs.forEach((element) {
              listaCategorias.add(Categorias.fromJson(element.data()));
            }));
  }

  Future<void> getBrands() async {
    listaRevendas.clear();
    listaRevendasNomes.clear();

    print('getBrands');
    //await fbInstance!.collection("akicategs").doc("Categorias").collection("lista").get().then((value) => value.docs.forEach((element) { listaCategorias.add(Categorias.fromJson(element.data())); }));

    await fbInstance!
        .collection("akirevendas")
        .doc("WY8Min9Tn7phgZV11n0V")
        .get()
        .then((value) {
      value.data()!.values.toList().forEach((element) {
        List<dynamic> lista = element;
        lista.sort();
        lista.forEach((ee) {
          listaRevendas.add(new Revendas(ee.toString(), ee.toString()));
          listaRevendasNomes.add(ee.toString());
        });
      });
    });

    listaRevendas.add(new Revendas('selecione', 'selecione'));
    listaRevendasNomes.add('selecione');
  }

  Future<void> loadOffersFavs() async {
    print('entrou no loadOffersFavs()');
    var offerfavRepository = new OfferfavRepository();

    if (refreshOfertasFavs) {
      refreshOfertasFavs = false;
      await offerfavRepository.updateCollection(ofertasFavs);
    }
    // ofertasFavs.clear();
    ofertasFavs = await offerfavRepository.getAll();
    print('qt ofertasFavs: ' + ofertasFavs.length.toString());
  }

  // atualiza tabela core local com a nuvem
  Future<void> runCore() async {
    // pega os valores da tabela nuvem
    var listCoreTemp = [];
    var coreFB = await fbPorakiService().getListFromFirebase("akicore", "core");
    listCoreTemp = await sqlPorakiCoreService().buscaTodosValores();

    var coreFBcep = await fbPorakiService()
        .getListFromFirebase("akicore", "057"); // cloudId.toString());
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

      // //faz o iteracao da tabela local contra a nuvem pra nao causar erro caso haja mais chaves na nuvem
      // coreSqlCep.forEach((coreItem) {
      //   print('coreSqlCep: ' + coreItem.toString());
      //   coreFBcep.forEach((key, value) {
      //     print('coreFBcep key: ' + key.toString() + ' / coreFBcep value: ' + value.toString());
      //
      //     //   print(key);
      //     //   var coreSqlUpdate =
      //     //       coreSqlCep.where((coreItem) => coreItem.coreChave == key).first;
      //     //   if (coreSqlUpdate.coreValor != value) {
      //     //     coreSqlUpdate.coreValor = value.toString();
      //     //     sqlPorakiCoreService().atualizaCoreCep(coreSqlUpdate);
      //     //   }
      //     var coreFBcepTemp = coreFB.entries
      //         .where((element) => element.key == coreItem.coreChave)
      //         .first;
      //     if (coreItem.coreValor != coreFBcepTemp.value) {
      //       coreItem.coreValor = coreFBcepTemp.value;
      //
      //       sqlPorakiCoreService().atualizaCoreCep(coreItem);
      //     }
      //   });
      // });

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

      // //faz o iteracao da tabela local contra a nuvem pra nao causar erro caso haja mais chaves na nuvem
      // coreSql.forEach((coreItem) {
      //   // print('coreItem: ' + coreItem.coreChave);
      //   var coreFBtemp = coreFB.entries
      //       .where((element) => element.key == coreItem.coreChave)
      //       .first;
      //   if (coreItem.coreValor != coreFBtemp.value) {
      //     coreItem.coreValor = coreFBtemp.value;
      //     print('coreItem atualizado: ' + coreItem.coreChave);
      //
      //     sqlPorakiCoreService().atualizaCore(coreItem);
      //   }
      // });

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
      //var _addressController = new AddressController();
      usuCep = '05735-030'; // await _addressController.getCepAtualLocal();
    }
    print('usuCep atual: ' + usuCep.toString());
  }

  Future<void> getListBannersFromFBCloud() async {
    // LoginController loginController = Get.find();

    var tempBannersApp =
        await fbPorakiService().getListFromFirebase("akibanners", "core");
    tempBannersApp.forEach((key, value) {
      print('banner: ' + value);
      listBanners.add(value);
    });
    var tempBannersCep = await fbPorakiService()
        .getListFromFirebase("akibanners", usuCep!.substring(0, 3));
    tempBannersCep.forEach((key, value) {
      listBanners.add(value);
    });
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

    // await loadUserData();
    // await runCore();
    // await loadOffersFavs();
    // await loadStoresData();

    // redireciona para a home de ofertas
    // Get.toNamed(AppRoutes.offer);
    Get.toNamed(AppRoutes.categories);

    // } else {
    //   print("invalido");
    // }

    //compara qtd de pedidos fechados com a nuvem e atualiza se for o caso

    //executa comandos na base local
  }
}
