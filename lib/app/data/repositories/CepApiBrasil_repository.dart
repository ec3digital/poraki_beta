import 'dart:convert';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/cepApiBrasil.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class CepApiBrasilRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<CepApiBrasil> getCepApiBrasil(String cep) async {
    var response = await get('${_loginController.listCore.where((coreItem) => coreItem.coreChave == 'cepservice').first.coreValor.toString()}' + cep, headers: _loginController.regionHeaders);

    return CepApiBrasil.fromJson(json.decode(response.bodyString.toString()));
  }
}
