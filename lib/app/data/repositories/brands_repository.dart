
import 'package:get/get.dart';
import 'package:poraki/app/data/models/revendas.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/shared/constants/constants.dart';

class BrandsRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<Revendas>> getAllBrands() async {
    //var url = '${Constants.baseUrl}' + '/revendas/' + _loginController.usuCep.toString().substring(0,3); //'${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid,
    var url = 'https://poraki.hasura.app/api/rest/revendas/';
    var response = await get(
        url,
        headers: Constants.headers);
    return (response.body['Revendas'] as List)
        .map((obj) => Revendas.fromJson(obj))
        .toList();
  }
}