import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/data/models/sql/sqlUsuario.dart';
import 'package:poraki/app/modules/auth/login/login_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:extended_masked_text/extended_masked_text.dart';
import '../../../data/models/login_model.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/constants/preferences_keys.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';

class SignUpController extends GetxController {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController mailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController confirmInputController = TextEditingController();
  TextEditingController surnameInputController = TextEditingController();
  TextEditingController cpfInputController = TextEditingController();
  TextEditingController dtNascInputController = TextEditingController();
  TextEditingController cepInputController = TextEditingController();
  TextEditingController phoneInputController = TextEditingController();

  bool showPassword = false;
  late String _userUID;
  // final formKey = Get.key; // GlobalKey<FormState>();

  Future<String> signUp(
      String email, String password, String displayName) async {
    print(Uri.parse(AppRoutes.signUpGoogle).toString());

    // try {} on auth.FirebaseAuthException catch (exception, s) { {}
    http.Response response = await http.post(
      Uri.parse(AppRoutes.signUpGoogle),
      body: json.encode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );

    var resp = response.body;

    if (resp.contains('idToken')) {
      var loginResp = await LoginService()
          .loginWithEmailAndPassword(email, password, displayName);

      print(loginResp);

      if (loginResp == 'OK') {
        //TODO: cadastrar na colecao akiusuarios, sendo o documento o User UID

        // salva usuário no sqlLocal, para ser recuperado depois qunado logar novamente
        LoginModel newUser = LoginModel(
          name: nameInputController.text,
          mail: mailInputController.text,
          password: passwordInputController.text,
          keepOn: true,
        );
        _saveUser(newUser);
      }

      return loginResp;
    } else {
      print(resp.toString());
      return 'Erro tentando registrar novo usuário no aplicativo';
    }
  }

  Future<String> doSignUp() async {
    // if (formKey.currentState!.validate()) {
      return await SignUpController().signUp(
          mailInputController.text.trim(),
          passwordInputController.text.trim(),
          nameInputController.text.trim() +
              ' ' +
              surnameInputController.text.trim());
    // } else {
    //   return '';
    // }
  }

  void changeShowPassword(bool newValue) {
    showPassword = newValue;
    update();
  }

  // ignore: unused_element
  void _saveUser(LoginModel user) async {
    //TODO: criar usuario no Firebase e pegar o ID
    //var uid = 'eyCv21RfaURoMn0SUndCg6LPyJP2';

    var sqlSvc = new sqlPorakiLoginService();
    var newUser = new sqlUsuarios(
        mailInputController.text.removeAllWhitespace,
        nameInputController.text.removeAllWhitespace,
        surnameInputController.text.removeAllWhitespace,
        cpfInputController.text.removeAllWhitespace,
        phoneInputController.text.removeAllWhitespace,
        cepInputController.text.removeAllWhitespace,
        '',
        '',
        '',
        DateTime.now().toString(),
        DateTime.now().toString(),
        '1.00');
    sqlSvc.insertUsuario(newUser);
  }
}
