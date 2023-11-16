import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertafav.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:http/http.dart' as http;

class OfferfavRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<OfertasFavs>> getAll() async {
    var response = await get('${_loginController.regionBaseUrl + _loginController.apiOfertasFavPerUserKeys}/' + _loginController.usuGuid.toString(), headers: _loginController.regionHeaders);
    if (response.hasError) throw 'Ocorreu um erro em OfertaFav.getAll()';
    return (response.body['OfertasFavs'] as List)
        .map((ofertafav) => OfertasFavs.fromJson(ofertafav))
        .toList();
  }

  Future<String> updateCollection(List<OfertasFavs> ofertasfavs) async {
    String resp = "";

      ofertasfavs.forEach((oFav) async {
        if(oFav.add)
          resp += await postObj(oFav);

        if(oFav.del)
          resp += await deleteObj(oFav);
      });

    return resp;
  }

  Future<String> postObj(OfertasFavs ofertafav) async {
    var response = await http.post(
        Uri.parse('${_loginController.regionBaseUrl + _loginController.apiOfertaFavAdd}/'),
        headers: _loginController.regionHeaders,
        body: ofertafav.toJson());
    var ret = response.body.toString();
    return ret;
  }

  Future<String> deleteObj(OfertasFavs ofertafav) async {
    var response = await http.delete(
        Uri.parse('${_loginController.regionBaseUrl + _loginController.apiOfertaFavDel}/'),
        headers: _loginController.regionHeaders,
        body: ofertafav.toJson());
    var ret = response.body.toString();
    print(ret);
    return ret;
  }

}
