import 'package:get/get.dart';
import '../../data/models/categorias.dart';
import '../../data/repositories/categories_repository.dart';

class CategoriesController extends GetxController {

  CategoriesRepository categoriesRepository = CategoriesRepository();

  List<Categorias>? categorias;

  List<String>? listaCategorias = [];

  bool isLoading = false;

  late Categorias categSelected;

  //get categ => null;

  @override
  void onInit() async {
    await getAllCategories();
    await getCategoriesNames();
    super.onInit();
  }

  Future<void> getAllCategories() async {
    try {
      changeLoading(true);
      categorias = await categoriesRepository.getAllCategories();
    } catch (e) {
      print('Erro no getAllCategories() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  Future<List<String>?> getCategoriesNames() async {
    try {
      changeLoading(true);
      await getAllCategories();
      listaCategorias?.clear();
      categorias!.forEach((categ) {listaCategorias!.add(categ.categoriaNome!.trimRight());});
      listaCategorias?.add('selecione');
      print(categorias);
      return listaCategorias;
    } catch (e) {
      print('Erro no getAllCategories() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  Categorias? selecionaCategoria(String categName) {
    if (listaCategorias!.isEmpty){
      return null;
    }
    else {
      return categorias?.where((categ) => categ.categoriaNome == categName).first;
    }
  }

}
