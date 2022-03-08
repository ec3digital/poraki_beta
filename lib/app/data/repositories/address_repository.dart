import 'package:get/get.dart';
import '../../shared/constants/constants.dart';
import '../models/enderecos.dart';

class AddressRepository extends GetConnect {
  String urlAll = '${Constants.baseUrl}enderecosporusuario/';
  String urlSingle = '${Constants.baseUrl}endereco/';
  String urlCurrent = '${Constants.baseUrl}enderecoatual/';

  Future<List<Enderecos>> getAllAddresses(String usuguid) async {
    var response = await get(urlAll + usuguid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em AddressRepository().getAllAddresses';
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj))
        .toList();
  }

  Future<List<Enderecos>> getAddress(String guid) async {
    var response = await get(urlSingle + guid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em AddressRepository().getAddress';
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj))
        .toList();
  }

  Future<List<Enderecos>> getCurrentAddress(String usuguid) async {
    var response = await get(urlCurrent + usuguid, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em AddressRepository().getCurrentAddress';
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj))
        .toList();
  }
}
