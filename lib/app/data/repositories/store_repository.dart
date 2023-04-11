import 'dart:convert';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import '../models/lojas.dart';
import 'package:http/http.dart' as http;

class StoreRepository extends GetConnect {
  LoginController _loginController = Get.find();
  // String urlAll = '${Constants.baseUrl}lojasporvendedor/';
  // String urlSingle = '${Constants.baseUrl}loja/';

  Future<List<Lojas>> getAllStores(String usuguid) async {
    return _loginController.listLojas;

    // var response = await get(urlAll + usuguid, headers: Constants.headers);
    // var response = await get('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid, headers: Constants.headers);
    //Uri uri = Uri.parse('${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid);
    // print('uri getAllStores: ' + uri.toString());


    // var response = await get(
    //     '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' +
    //         usuguid,
    //     headers: Constants.headers);
    // return (response.body['Lojas'] as List)
    //     .map((obj) => Lojas.fromJson(obj))
    //     .toList();
  }

  Future<Lojas> getStore(String guid) async {
    return _loginController.listLojas.where((loja) => loja.LojaGUID == guid).first;

    // var response = await get(
    //     '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLoja').first.coreValor.toString()}/' +
    //         guid,
    //     headers: Constants.headers);
    // // if (response.err.hasError) throw 'Ocorreu um erro em StoreRepository().getStore';
    // return (response.body as List<Lojas>)
    //     .map((obj) => Lojas.fromJson(jsonDecode(obj.toString())))
    //     .toList()
    //     .first;
  }

  Future<String> postStore(Lojas loja) async {
    var retAdd = await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").add(loja.toJson());

    print(retAdd.id);
    return retAdd.id;

    // var response = await http.post(
    //     Uri.parse(
    //         '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLoja').first.coreValor.toString()}'),
    //     headers: Constants.headers,
    //     body: loja.toJson());
    //
    // print(response.body);
    // return response.body;

    // var jsonResp = jsonDecode(response.body);
    // var strGuid = jsonResp['insert_Ofertas_one']['OfertaGUID'];
  }

  Future<String> putStore(Lojas loja) async {
    String getId = '';
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").where('LojaGUID', isEqualTo: loja.LojaGUID).get().then((ss) => getId = ss.docs.first.id);
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").doc(getId).set(loja.toJson());

    return getId;

    // var response = await http.put(
    //   Uri.parse(
    //       '${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLoja').first.coreValor.toString()}'),
    //   headers: Constants.headers,
    //   body: loja.toJson(),
    // );
    //
    // print(response.body);
    // return response.body;
  }

  Future<void> deleteStore(Lojas loja) async {
    String getId = '';
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").where('LojaGUID', isEqualTo: loja.LojaGUID).get().then((ss) => getId = ss.docs.first.id);
    await _loginController.fbInstance!.collection("akilojas").doc(_loginController.usuGuid).collection("Lojas").doc(getId).delete();
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
