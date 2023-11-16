import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../models/chats.dart';
import 'package:http/http.dart' as http;

class ChatRepository extends GetConnect {
  LoginController _loginController = Get.find();

  Future<List<Chats>> getAllByCustomerId() async {
    var url = 'https://poraki.hasura.app/api/rest/chatsbycustomer/';
    var response = await get(
        url,
        headers: _loginController.regionHeaders);
    return (response.body['Chats'] as List)
        .map((obj) => Chats.fromJson(obj))
        .toList();
  }

  Future<List<Chats>> getAllBySellerId() async {
    var url = 'https://poraki.hasura.app/api/rest/chatsbyseller/';
    var response = await get(
        url,
        headers: _loginController.regionHeaders);
    var resp = response.body['Chats'];
    return (resp as List)
        .map((obj) => Chats.fromJson(obj))
        .toList();
  }

  Future<void> add(Chats chat) async {
    var url = 'https://poraki.hasura.app/api/rest/chatadd/';
    await http.post(
        Uri.parse(url),
        headers: _loginController.regionHeaders,
        body: chat.toJson());

  }

  Future<void> close(String chatId) async {
    var url = 'https://poraki.hasura.app/api/rest/chatend/' + chatId;
    await http.put(
        Uri.parse(url),
        headers: _loginController.regionHeaders);
  }

}