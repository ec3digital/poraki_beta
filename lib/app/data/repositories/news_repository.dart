import 'package:get/get.dart';
import 'package:poraki/app/data/models/noticias.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';

class NewsRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<Noticia>> getAllNews() async {
    var url = '${Constants.baseUrl}' + '/noticias/' + _loginController.cloudId.toString(); //'${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid,
    var response = await get(
        url,
        headers: Constants.headers);
    return (response.body['Noticias'] as List)
        .map((obj) => Noticia.fromJson(obj))
        .toList();
  }
}