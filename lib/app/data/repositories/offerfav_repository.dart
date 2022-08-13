import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import 'package:http/http.dart' as http;

class OfferfavRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<OfertasFavs>> getAll() async {
    String url = 'https://poraki.hasura.app/api/rest/ofertasfavperuserkeys/' + _loginController.usuGuid.toString();
    print('OfertasFavs.getAll() - ' + url.toString());
    var response = await get(url, headers: Constants.headers);
    if (response.hasError) throw 'Ocorreu um erro em OfertaFav.getAll()';
    return (response.body['OfertasFavs'] as List)
        .map((ofertafav) => OfertasFavs.fromJson(ofertafav))
        .toList();
  }

  Future<String> postObj(OfertasFavs ofertafav) async {
    String url = 'https://poraki.hasura.app/api/rest/ofertafavadd/';
    var response = await http.post(
        Uri.parse(url),
        //Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEndereco').first.coreValor.toString()}'),
        headers: Constants.headers,
        body: ofertafav.toJson());
    // if (response.er)
    //   throw 'Ocorreu um erro em OrdersRepository().postAddress()';
    return response.body.toString();
  }

  Future<String> deleteObj(OfertasFavs ofertafav) async {
    String url = 'https://poraki.hasura.app/api/rest/ofertafavdel/';
    var response = await http.delete(
        Uri.parse(url),
      //Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiEndereco').first.coreValor.toString()}'),
        headers: Constants.headers,
        body: ofertafav.toJson());
    return response.body.toString();
  }

}
