import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poraki/shared/constants/routes.dart';

class LoginService {
  login(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse(Routes.login),
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
