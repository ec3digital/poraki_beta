import 'package:get/get.dart';
import 'package:poraki/app/data/models/noticias.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class NewsRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<Noticia>> getAllNews() async {
    var response = await get(
        '${_loginController.regionBaseUrl}' + '/noticias/' + _loginController.cloudId.toString(),
        headers: _loginController.regionHeaders);
    return (response.body['Noticias'] as List)
        .map((obj) => Noticia.fromJson(obj))
        .toList();
  }
}