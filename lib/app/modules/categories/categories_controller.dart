import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/qtdcategorias.dart';
import '../../data/models/categorias.dart';
import '../../data/repositories/categories_repository.dart';
import '../auth/login/login_controller.dart';

class CategoriesController extends GetxController {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  List<Categorias> categorias = [];
  List<qtdcategorias> qtdCategs = [];
  List<String>? listaCategoriasNomes = [];
  bool isLoading = false;
  late Categorias categSelected;
  final LoginController _loginController = Get.find();

  //get categ => null;

  @override
  void onInit() async {
    if(_loginController.listaCategorias.isEmpty) {
      await getAllCategoriesFb();
      await getCategoriesNamesFb();

    }

    await getQtyCategs();

    _loginController.listaCategorias.forEach((categ) { categorias.add(categ); });
    _loginController.listaCategorias.sort((a, b) => a.categoriaNome.toString().compareTo(b.categoriaNome.toString()));

    super.onInit();
  }

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
  //
  // Future<List<String>?> getCategoriesNames() async {
  //   try {
  //     changeLoading(true);
  //     await getAllCategories();
  //     listaCategorias!.clear();
  //     categorias.forEach((categ) {listaCategorias!.add(categ.categoriaNome!.trimRight());});
  //     listaCategorias!.add('selecione');
  //     return listaCategorias;
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

  Future<Categorias?> selecionaCategoriaPorNome(String categName) async {
    print('selecionaCategoriaPorNome: $categName');
    if (listaCategoriasNomes!.isEmpty) {
      print('listaCategoriasNomes vazia');
      final CategoriesController categoriesController = Get.find();
      await categoriesController.getCategoriesNamesFb();
    }
      print('procura categoria: $categName');
      return categorias
          .where((categ) => categ.categoriaNome == categName)
          .first;
  }

  Categorias? selecionaCategoriaPorChave(String categKey) {
    print('categKey: ' + categKey);
    if (categorias.isEmpty) {
      return null;
    } else {
      return categorias
          .where((categ) =>
              categ.categoriaChave!.trimRight() == categKey.trimRight())
          .first;
    }
  }

  Future<void> getAllCategoriesFb() async {
    print('getAllCategoriesFb');

    if (categorias.isEmpty) {
      FirebaseFirestore? _fbInstance;
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      _fbInstance = FirebaseFirestore.instance;
      //criar mapping de revendas e jogar o toList no mapping e depois iterar
      //List<dynamic> categs = [];
      // var tempCategs = [];
      // await _fbInstance.collection("akicategs").doc("Categorias").collection("lista").get().then((value) => value.docs.forEach((element) { tempCategs.add(element.data()); }));
      // tempCategs.forEach((element) { print(element['CategoriaNome']);});
      // print('tipo: ' + tempCategs. ..toString());
      // await _fbInstance.collection("akicategs").doc("Categorias").collection("lista").get().then((value) => value.docs.forEach((element) { categorias?.add(Categorias.fromJson(element.data())); }));
      try {
        changeLoading(true);
        await _fbInstance
            .collection("akicategs")
            .doc("Categorias")
            .collection("lista")
            .get()
            .then((value) => value.docs.forEach((element) {
                  categorias.add(Categorias.fromJson(element.data()));
                }));
      } catch (e) {
        print('Erro no getAllCategories() controller ${e.toString()}');
      } finally {
        changeLoading(false);
      }
    }

    //categorias!.forEach((categ) { print(categ.categoriaNome!.trimRight());});
    //categs.forEach((e) { print(e); });
  }

  Future<List<String>?> getCategoriesNamesFb() async {
    print('getCategoriesNamesFb');
    try {
      changeLoading(true);
      await getAllCategoriesFb();
      listaCategoriasNomes!.clear();
      categorias.forEach((categ) {
        listaCategoriasNomes!.add(categ.categoriaNome!.trimRight());
      });
      // listaCategoriasNomes!.add('selecione');
      return listaCategoriasNomes;
    } catch (e) {
      print('Erro no getCategoriesNamesFb() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

Future<void> getQtyCategs() async {
    print('passou no getQtyCategs');
    // LoginController _loginController = Get.find();
    // offers = _loginController.ofertasFavs;
    // var categRepo

    try {
      changeLoading(true);
      qtdCategs.clear();
      qtdCategs = await categoriesRepository.getQtdCategorias();
      this.refresh();
    } catch (e) {
      print('Erro no getQtyCategs() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

}
