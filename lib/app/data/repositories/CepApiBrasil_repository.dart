import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/data/models/cepApiBrasil.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/shared/constants/constants.dart';

class CepApiBrasilRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<CepApiBrasil> getCepApiBrasil(String cep) async {
    // String url = 'https://brasilapi.com.br/api/cep/v2/' + cep;
    // var response = await http.get(Uri.parse(url));

    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'cepservice').first.coreValor.toString()}', headers: Constants.headers);

    return CepApiBrasil.fromJson(json.decode(response.body));
  }
}
