import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/data/models/sql/sqlUsuario.dart';
import 'package:poraki/app/data/models/usuario.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/auth/login/login_service.dart';
import '../../../routes/app_routes.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpController extends GetxController {
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController mailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final TextEditingController confirmInputController = TextEditingController();
  final TextEditingController surnameInputController = TextEditingController();
  final TextEditingController cpfInputController = TextEditingController();
  final TextEditingController dtNascInputController = TextEditingController();
  final TextEditingController cepInputController = TextEditingController();
  final TextEditingController phoneInputController = TextEditingController();
  final TextEditingController nickInputController = TextEditingController();

  bool showPassword = false;
  // late String _userUID;
  // final formKey = Get.key; // GlobalKey<FormState>();

  Future<String> signUp(
      String email, String password, String displayName, String nomeCompleto, String formCep, String formCpf, String formWhatsApp) async {
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

    if (resp.contains('EXISTS'))
      return 'E-mail já existe';

    if (resp.contains('INVALID'))
      return 'E-mail inválido';

    if (resp.contains('WEAK'))
      return 'Senha muito fraquinha, por favor tente outra ;-)';

    if (resp.contains('idToken')) {
      var _loginSvc = new LoginService();

      var loginResp = await
      _loginSvc.loginWithEmailAndPassword(email, password, displayName);

      print(loginResp);

      if (loginResp == 'OK') {
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp();
        }

        _loginSvc.CurrentUserObject!.updateDisplayName(nickInputController.text.trim());

        var user = new Usuario(
            nome: nomeCompleto,
            apelido: displayName,
            cep: formCep,
            cpf: formCpf,
            email: _loginSvc.CurrentUserObject!.email,
            whatsapp: formWhatsApp,
            cpfValidado: false,
            regiao: '057',
            dataNascimento: DateTime.now());

        LoginController _loginController = Get.find();
        _loginController.usuEmail = email;
        _loginController.usuNome = displayName;
        _loginController.usuCep = formCep;
        _loginController.usuGuid = _loginSvc.CurrentUserObject!.uid.toString();
        await _loginController.fbInstance!
            .collection("akiusuarios")
            .doc(_loginSvc.CurrentUserObject!.uid.toString())
            .set(user.toJsonAdd());

        // envia e-mail de boas-vindas
        // _loginSvc.CurrentUserObject!.sendEmailVerification();

        // salva usuário no sqlLocal, para ser recuperado depois quando logar novamente
        _saveUser();

        FirebaseAuth.instance.signOut();
      }

      return loginResp;
    } else {
      print(resp.toString());
      return 'Erro tentando registrar novo usuário no aplicativo';
    }
  }

  // Future<String> doSignUp(String email, String pw, String apelido) async {
  //   // if (formKey.currentState!.validate()) {
  //   return await SignUpController().signUp(
  //       mailInputController.text.trim(),
  //       passwordInputController.text.trim(),
  //       nameInputController.text.trim() +
  //           ' ' +
  //           surnameInputController.text.trim());
  //   // } else {
  //   //   return '';
  //   // }
  // }

  void changeShowPassword(bool newValue) {
    showPassword = newValue;
    update();
  }

  // ignore: unused_element
  void _saveUser() async {

    var sqlSvc = new sqlPorakiLoginService();
    var newUser = new sqlUsuarios(
      mailInputController.text.removeAllWhitespace,
      '',
      // nameInputController.text.removeAllWhitespace,
      // surnameInputController.text.removeAllWhitespace,
      // cpfInputController.text.removeAllWhitespace,
      // phoneInputController.text.removeAllWhitespace,
      // cepInputController.text.removeAllWhitespace,
      // '',
      // '',
      // '',
      // DateTime.now().toString(),
      // DateTime.now().toString(),
      // '1.00'
    );
    sqlSvc.insertUsuario(newUser);
  }
}
