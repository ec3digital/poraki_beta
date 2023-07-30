import 'package:get/get.dart';
import 'package:poraki/app/data/models/qtdcategorias.dart';
import '../../shared/constants/constants.dart';
import '../models/categorias.dart';

class CategoriesRepository extends GetConnect {
  // LoginController _loginController = Get.find();
  // String url = '${Constants.baseUrl}categorias';
  // String urlBarra = '${Constants.baseUrl}categoriasbarra';
  //
  // Future<List<Categorias>> getAllCategories() async {
  //   var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiCategorias').first.coreValor.toString()}', headers: Constants.headers);
  //   if (response.hasError) throw 'Ocorreu um erro em CategoriesRepository().getAllCategories()';
  //   // var res = response.body;
  //   // print('categs: ' + res);
  //   return (response.body['Categorias'] as List)
  //       .map((categorias) => Categorias.fromJson(categorias))
  //       .toList();
  // }
  //
  // Future<List<Categorias>> getCategoriesBarra() async {
  //   // var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiCategoriasBarra').first.coreValor.toString()}', headers: Constants.headers);
  //   var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiCategorias').first.coreValor.toString()}', headers: Constants.headers);
  //   if (response.hasError) throw 'Ocorreu um erro em CategoriesRepository().getCategoriesBarra()';
  //   return (response.body['Categorias'] as List)
  //       .map((categorias) => Categorias.fromJson(categorias))
  //       .toList();
  // }

  Future<List<qtdcategorias>> getQtdCategorias() async {
    // var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiCategoriasBarra').first.coreValor.toString()}', headers: Constants.headers);

    String url = Constants.baseUrl + 'qtdcategorias/';
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em CategoriesRepository().getQtdCategorias()';
    return (response.body['qtdcategorias'] as List)
        .map((qtdcateg) => qtdcategorias.fromJson(qtdcateg))
        .toList();
  }
}
