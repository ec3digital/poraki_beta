import 'dart:convert';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/cepApiBrasil.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class CepApiBrasilRepository extends GetConnect {

  Future<CepApiBrasil> getCepApiBrasil(String cep) async {
    final LoginController _loginController = Get.find();
    await _loginController.getFBParams();
    var response = await get('${_loginController.cepSvcUrl}' + cep);

    return CepApiBrasil.fromJson(json.decode(response.bodyString.toString()));
  }
}
