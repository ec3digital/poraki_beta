import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/data/models/cepApiBrasil.dart';

class CepApiBrasilRepository extends GetConnect {
  Future<CepApiBrasil> getCepApiBrasil(String cep) async {
    String url = 'https://brasilapi.com.br/api/cep/v2/' + cep;
    var response = await http.get(Uri.parse(url));

    return CepApiBrasil.fromJson(json.decode(response.body));
  }
}
