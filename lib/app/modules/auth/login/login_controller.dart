import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/enderecos.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/data/models/sql/sqlCore.dart';
import 'package:poraki/app/data/repositories/offerfav_repository.dart';
import 'package:poraki/app/services/fbporaki_service.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_core_service.dart';
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
  get obscurePassword => _obscurePassword;

  List<String> listBanners = [
    'http://poraki-assets.ec3.digital/wp-content/uploads/2021/11/PORAKI-Banner-sm_default1.jpg',
  ];
  List<sqlCore> listCore = [];
  List<sqlCore> listCoreCep = [];
  List<Enderecos> listaEnderecos = [];
  List<Lojas> listLojas = [];
  //List<OfertasFavs> ofertasFavs = [];
  List<ProdutoOferta> ofertasFavs = [];
  List<Categorias> listaCategorias = [];
  // List<Revendas> listaRevendas = [];
  List<String> listaRevendasNomes = [];
  bool _obscurePassword = false;
  bool refreshOfertasFavs = false;
  String? usuCep;
  String? usuNome;
  String? usuEmail;
  String? usuGuid;
  String cloudId = "057";
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
    usuGuid = auth!.currentUser!.uid.toString();
    usuEmail = auth!.currentUser!.email.toString();
    usuNome = auth!.currentUser!.displayName.toString();

    //pega o cep local
    //await _getCep();
  }

  // carrega endereços do usuario
  Future<void> loadAddressData() async {
    //TODO: voltar esse codigo quando colocar endereços
    // listaEnderecos.clear();
    // await fbInstance!
    //     .collection("akienderecos")
    //     .doc(auth!.currentUser!.uid)
    //     .collection("Enderecos")
    //     .get()
    //     .then((value) => value.docs.forEach((element) {
    //           listaEnderecos.add(Enderecos.fromJson(element.data()));
    //         }));
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
    // listaRevendas.clear();
    listaRevendasNomes.clear();

    await fbInstance!
        .collection("akirevendas")
        .doc("WY8Min9Tn7phgZV11n0V")
        .get()
        .then((value) {
      value.data()!.values.toList().forEach((element) {
        List<dynamic> lista = element;
        lista.sort();
        lista.forEach((ee) {
          // listaRevendas.add(new Revendas(ee.toString(), ee.toString()));
          listaRevendasNomes.add(ee.toString());
        });
      });
    });

    // listaRevendas.add(new Revendas('selecione', 'selecione'));
    listaRevendasNomes.add('selecione');
  }

  Future<void> loadOffersFavs() async {
    print('entrou no loadOffersFavs()');
    var offerfavRepository = new OfferfavRepository();

    // if (refreshOfertasFavs) {
    //   refreshOfertasFavs = false;
      //await offerfavRepository.updateCollection(ofertasFavs);
    // }
    // // ofertasFavs.clear();

    // ofertasFavs = await offerfavRepository.getAll();
    //ofertasFavs = await offer
    print('qt ofertasFavs: ' + ofertasFavs.length.toString());
  }

  // atualiza tabela core local com a nuvem
  Future<void> runCore() async {
    // pega os valores da tabela nuvem
    var listCoreTemp = [];
    var coreFB = await fbPorakiService().getListFromFirebase("akicore", "core");
    listCoreTemp = await sqlPorakiCoreService().buscaTodosValores();

    // var coreFBcep = await fbPorakiService().getListFromFirebase("akicore", "057"); // cloudId.toString());
    var stringCloud = cloudId.isEmpty ? "057" : cloudId.substring(0,3);
    var coreFBcep = await fbPorakiService().getListFromFirebase("akicore", stringCloud);
    listCoreCep = await sqlPorakiCoreService().buscaTodosValoresCep();
    if (coreFBcep.isNotEmpty) {
      // reseta tabela core local cep
      await sqlPorakiCoreService().resetaTabelaCep();
      // verifica tabela core local cep
      await sqlPorakiCoreService().verificaTabelaCep();
      // insere os valores iniciais cep
      await sqlPorakiCoreService().valoresIniciaisCep();

      // atualiza lista de params core
      listCoreCep = await sqlPorakiCoreService().buscaTodosValoresCep();
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
    var tempBannersApp =
        await fbPorakiService().getListFromFirebase("akibanners", "core");
    tempBannersApp.forEach((key, value) {
      print('banner: ' + value);
      listBanners.add(value);
    });
    var tempBannersCep = await fbPorakiService()
        .getListFromFirebase("akibanners", cloudId.toString());
    tempBannersCep.forEach((key, value) {
      listBanners.add(value);
    });
  }

  // valida o login
  void doLogin(BuildContext context) async {
    Get.toNamed(AppRoutes.categories);

    //executa comandos na base local

  }
}
