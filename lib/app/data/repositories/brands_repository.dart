import 'package:get/get.dart';
import 'package:poraki/app/data/models/revendas.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class BrandsRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<Revendas>> getAllBrands() async {
    var response = await get(
        '${_loginController.regionBaseUrl}/revendas',
        headers: _loginController.regionHeaders);
    return (response.body['Revendas'] as List)
        .map((obj) => Revendas.fromJson(obj))
        .toList();
  }
}