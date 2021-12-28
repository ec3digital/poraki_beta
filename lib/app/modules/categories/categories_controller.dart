import 'package:get/get.dart';
import '../../data/models/categorias.dart';
import '../../data/repositories/categories_repository.dart';

class CategoriesController extends GetxController {

  CategoriesRepository categoriesRepository = CategoriesRepository();

  List<Categorias>? categorias;

  bool isLoading = false;

  @override
  void onInit() async {
    await getAllCategories();
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

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

}
