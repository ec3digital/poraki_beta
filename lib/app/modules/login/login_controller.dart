import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/routes/app_routes.dart';

class LoginController extends GetxController {
  login(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse(AppRoutes.SIGN_IN),
      body: json.encode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );

    print(response.body);
  }
}
