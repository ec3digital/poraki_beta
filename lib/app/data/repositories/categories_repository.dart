import 'package:get/get.dart';

import '../../shared/constants/constants.dart';
import '../models/categorias.dart';

class CategoriesRepository extends GetConnect {
  String url = '${Constants.baseUrl}categorias';

  Future<List<Categorias>> getAllCategories() async {
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em CategoriesRepository()';
    return (response.body['Categorias'] as List)
        .map((categorias) => Categorias.fromJson(categorias))
        .toList();
  }
}
