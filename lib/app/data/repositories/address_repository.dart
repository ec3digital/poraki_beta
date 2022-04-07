import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import '../models/enderecos.dart';

class AddressRepository extends GetConnect {
  LoginController _loginController = Get.find();
  // String urlAll = '${Constants.baseUrl}enderecosporusuario/';
  // String urlAll = '${Constants.baseUrl + _loginController.apiEnderecos.toString()}/';
  // String urlSingle = '${Constants.baseUrl}endereco/';
  // String urlCurrent = '${Constants.baseUrl}enderecoatual/';

  Future<List<Enderecos>> getAllAddresses() async {
    // print('getAllAddresses usuguid: ' + urlAll + usuguid);
    // var response = await get(urlAll + usuguid, headers: Constants.headers);
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEnderecos').first.coreValor.toString()}/' + _loginController.usuGuid.toString(), headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em AddressRepository().getAllAddresses';
    print(response.body);
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj))
        .toList();
  }

  // Future<List<Enderecos>> getAddress(String guid) async {
  //   // var response = await get(urlSingle + guid, headers: Constants.headers);
  //   var response = await get('${Constants.baseUrl + _loginController.apiEnderecos.toString()}/' + guid, headers: Constants.headers);
  //   if (response.hasError) throw 'Ocorreu um erro em AddressRepository().getAddress';
  //   return (response.body['Enderecos'] as List)
  //       .map((obj) => Enderecos.fromJson(obj))
  //       .toList();
  // }

  Future<Enderecos> getCurrentAddress() async {
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEnderecoAtual').first.coreValor.toString()}/' + _loginController.usuGuid.toString(), headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em AddressRepository().getCurrentAddress';
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj))
        .toList().first;
  }
}
