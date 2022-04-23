import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import '../models/enderecos.dart';
import 'package:http/http.dart' as http;

class AddressRepository extends GetConnect {
  LoginController _loginController = Get.find();


  Future<List<Enderecos>> getAllAddresses() async {
    var response = await get(
        '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEnderecos').first.coreValor.toString()}/' +
            _loginController.usuGuid.toString(),
        headers: Constants.headers);
    if (response.hasError)
      throw 'Ocorreu um erro em AddressRepository().getAllAddresses';
    print(response.body);
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj))
        .toList();
  }

  Future<Enderecos> getAddress(String enderecoGuid) async {
    var response = await get(
        '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEnderecos').first.coreValor.toString()}/' + enderecoGuid,
        headers: Constants.headers);
    if (response.hasError)
      throw 'Ocorreu um erro em AddressRepository().getAddress';
    print(response.body);
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj)).first;
  }

  Future<Enderecos> getCurrentAddress() async {
    var response = await get(
        '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEnderecoAtual').first.coreValor.toString()}/' +
            _loginController.usuGuid.toString(),
        headers: Constants.headers);
    if (response.hasError)
      throw 'Ocorreu um erro em AddressRepository().getCurrentAddress';
    return (response.body['Enderecos'] as List)
        .map((obj) => Enderecos.fromJson(obj))
        .toList()
        .first;
  }

  Future<String> postAddress(Enderecos endereco) async {
    var response = await http.post(
        Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEndereco').first.coreValor.toString()}'),
        headers: Constants.headers,
        body: endereco.toJson());
    // if (response.er)
    //   throw 'Ocorreu um erro em OrdersRepository().postAddress()';
    return response.body.toString();
  }

  Future<String> putAddress(Enderecos endereco) async {
    var response = await http.put(
        Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEndereco').first.coreValor.toString()}'),
        headers: Constants.headers,
        body: endereco.toJson());
    return response.body.toString();
  }

  Future<String> putCurrentAddress(String enderecoGuid) async {
    print('putCurrentAddress');
    var response = await http.put(
        Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEnderecoAtual').first.coreValor.toString()}/' + enderecoGuid),
        headers: Constants.headers,
        body: '');
    return response.body.toString();
  }

  Future<String> putCurrentNAddress(String enderecoGuid) async {
    print('putCurrentNAddress');
    var response = await http.put(
        Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEnderecoNAtual').first.coreValor.toString()}/' + enderecoGuid),
        headers: Constants.headers,
        body: '');
    return response.body.toString();
  }

}
