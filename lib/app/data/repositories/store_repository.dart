import 'dart:convert';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import '../models/lojas.dart';
//import 'package:http/http.dart';

class StoreRepository extends GetConnect {
  LoginController _loginController = Get.find();
  // String urlAll = '${Constants.baseUrl}lojasporvendedor/';
  // String urlSingle = '${Constants.baseUrl}loja/';

  Future<List<Lojas>> getAllStores(String usuguid) async {
    // var response = await get(urlAll + usuguid, headers: Constants.headers);
    // var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid, headers: Constants.headers);
    //Uri uri = Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid);
    // print('uri getAllStores: ' + uri.toString());
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid, headers: Constants.headers);
    print('response getAllStores 1: ' + response.body.toString());
    // if (response.hasError) throw 'Ocorreu um erro em StoreRepository().getAllStores';
    //Map<String, dynamic> mapresp = json.decode(response.body);

    //print('json decode: ' + (json.decode(response.body[0].toString()) as List<Lojas>).length.toString());
    //var tempLojas = (json.decode(response.body) as List);
    // print('tempLojas: ' + tempLojas.toString());

    //List<Lojas> lojas = tempLojas.map((e) => Lojas.fromJson(e)).toList();
    // print(mapresp.toString());
    // List<Lojas> retlist = [];
    // mapresp.forEach((element) {
    //   print('entrou no foreach');
    //   print(element.toString());
    //   retlist.add(Lojas.fromJson(element));
    // });
    //List<Lojas> ret = [];
    return (response.body['Lojas'] as List)
        .map((obj) => Lojas.fromJson(obj))
        .toList();
  }

  Future<Lojas> getStore(String guid) async {
    // var response = await get(urlSingle + guid, headers: Constants.headers);
    var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLoja').first.coreValor.toString()}/' + guid, headers: Constants.headers);
    // if (response.err.hasError) throw 'Ocorreu um erro em StoreRepository().getStore';
    return (response.body as List<Lojas>)
        .map((obj) => Lojas.fromJson(jsonDecode(obj.toString())))
        .toList().first;
  }

  Future<void> postStore(Lojas loja) async {
    var response = await post(
        '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLoja').first.coreValor.toString()}',
        loja.toJson(),
    );

    print(response.body);
    // var jsonResp = jsonDecode(response.body);
    // var strGuid = jsonResp['insert_Ofertas_one']['OfertaGUID'];
  }

  Future<void> putStore(Lojas loja) async {
    var response = await put(
      '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLoja').first.coreValor.toString()}',
      loja.toJson(),
    );

    print(response.body);
  }

  // Future<void> inactiveStore(String lojaGuid) async {
  //   var response = await put(
  //     '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLoja').first.coreValor.toString()}',
  //     "",
  //   );
  //
  //   print(response.body);
  // }

}
