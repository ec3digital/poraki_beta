import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../../data/models/categorias.dart';
import '../../data/repositories/categories_repository.dart';

class CategoriesController extends GetxController {
  CategoriesRepository categoriesRepository = CategoriesRepository();
  List<Categorias> categorias = [];
  List<String>? listaCategoriasNomes = [];
  bool isLoading = false;
  late Categorias categSelected;

  //get categ => null;

  @override
  void onInit() async {
    await getAllCategoriesFb();
    await getCategoriesNamesFb();
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

  Categorias? selecionaCategoriaPorNome(String categName) {
    if (listaCategoriasNomes!.isEmpty) {
      return null;
    } else {
      return categorias
          .where((categ) => categ.categoriaNome == categName)
          .first;
    }
  }

  Categorias? selecionaCategoriaPorChave(String categKey) {
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
}
