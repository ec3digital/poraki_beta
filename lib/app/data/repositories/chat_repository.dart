import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../shared/constants/constants.dart';
import '../models/chats.dart';
import 'package:http/http.dart' as http;

class ChatRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<Chats>> getAllByCustomerId() async {
    //var url = '${Constants.baseUrl}' + '/noticias/' + _loginController.usuCep.toString().substring(0,3); //'${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid,

    var url = 'https://poraki.hasura.app/api/rest/chatsbycustomer/';
    var response = await get(
        url,
        headers: Constants.headers);
    return (response.body['Chats'] as List)
        .map((obj) => Chats.fromJson(obj))
        .toList();
  }

  Future<List<Chats>> getAllBySellerId() async {
    //var url = '${Constants.baseUrl}' + '/noticias/' + _loginController.usuCep.toString().substring(0,3); //'${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid,

    var url = 'https://poraki.hasura.app/api/rest/chatsbyseller/';
    var response = await get(
        url,
        headers: Constants.headers);
    var resp = response.body['Chats'];
    //print(resp.toString());
    return (resp as List)
        .map((obj) => Chats.fromJson(obj))
        .toList();
  }

  Future<void> add(Chats chat) async {
    //var url = '${Constants.baseUrl}' + '/noticias/' + _loginController.usuCep.toString().substring(0,3); //'${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid,
    var url = 'https://poraki.hasura.app/api/rest/chatadd/';

    await http.post(
        Uri.parse(url),
        headers: Constants.headers,
        body: chat.toJson());

  }

  Future<void> close(String chatId) async {
    //var url = '${Constants.baseUrl}' + '/noticias/' + _loginController.usuCep.toString().substring(0,3); //'${Constants.baseUrl + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'apiLojasPorVendedor').first.coreValor.toString()}/' + usuguid,
    var url = 'https://poraki.hasura.app/api/rest/chatend/' + chatId;

    await http.put(
        Uri.parse(url),
        headers: Constants.headers);
  }

}