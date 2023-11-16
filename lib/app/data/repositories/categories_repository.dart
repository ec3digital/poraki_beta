import 'package:get/get.dart';
import 'package:poraki/app/data/models/qtdcategorias.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class CategoriesRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<qtdcategorias>> getQtdCategorias() async {
    var response = await get('${_loginController.regionBaseUrl}/qtdcategorias',
        headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em CategoriesRepository().getQtdCategorias()';
    return (response.body['qtdcategorias'] as List)
        .map((qtdcateg) => qtdcategorias.fromJson(qtdcateg))
        .toList();
  }
}
