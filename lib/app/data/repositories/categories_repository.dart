import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import '../models/categorias.dart';

class CategoriesRepository extends GetConnect {
  LoginController _loginController = Get.find();
  // String url = '${Constants.baseUrl}categorias';
  // String urlBarra = '${Constants.baseUrl}categoriasbarra';

  Future<List<Categorias>> getAllCategories() async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiCategorias').first.coreValor.toString()}', headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em CategoriesRepository().getAllCategories()';
    // var res = response.body;
    // print('categs: ' + res);
    return (response.body['Categorias'] as List)
        .map((categorias) => Categorias.fromJson(categorias))
        .toList();
  }

  Future<List<Categorias>> getCategoriesBarra() async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiCategoriasBarra').first.coreValor.toString()}', headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em CategoriesRepository().getCategoriesBarra()';
    return (response.body['Categorias'] as List)
        .map((categorias) => Categorias.fromJson(categorias))
        .toList();
  }
}
