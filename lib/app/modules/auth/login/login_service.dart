import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'login_controller.dart';

class LoginService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();

  late auth.User? _currentUserObject;
  late auth.User? CurrentUserObject;


  login(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse(AppRoutes.login),
      body: json.encode(
        {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        },
      ),
    );

    // print(response.body);
  }

  // set currentUserObject(dynamic loggedUser) {
  //   this._currentUserObject = loggedUser;
  // }

  Future<String> loginWithEmailAndPassword(String email, String password, String? displayName) async {
    print('loginWithEmailAndPassword');
    try {
      await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _currentUserObject = auth.FirebaseAuth.instance.currentUser;
      CurrentUserObject = _currentUserObject;
      //final currentUserObject = auth.FirebaseAuth.instance.currentUser;

      if (CurrentUserObject?.uid != null) {
        final LoginController _loginController = Get.put(LoginController());
        _loginController.usuGuid = CurrentUserObject!.uid;
        _loginController.usuEmail = CurrentUserObject!.email;

        var u = CurrentUserObject;
        // print('usuario fb uid: ' + u!.uid.toString());
        // print('usuario fb email:' + u.email.toString());
        // print('usuario fb display name: ' + u.displayName.toString());
        // print('usuario fb phone#: ' + u.phoneNumber.toString());
        // print('usuario fb token: ' + u.refreshToken.toString());

        if(displayName != null) u!.updateDisplayName(displayName);

        return 'OK';
      }
    } on auth.FirebaseAuthException catch (exception, s) {
      if ((exception).code == 'invalid-email')
        return 'Endereço de e-mail informado incorretamente';

      if ((exception).code == 'wrong-password') return 'Senha incorreta';

      if ((exception).code == 'user-not-found') return 'Usuário não encontrado';

      if ((exception).code == 'user-disabled') return 'Usuário não permitido';

      if ((exception).code == 'too-many-requests')
        return 'Usuário bloqueado temporariamente';

      print(exception.toString() + '$s');
      return 'Ops, ocorreu um erro inesperado. Por favor tente novamente';
    } catch (e, s) {
      print(e.toString() + '$s');
      return 'Ocorreu um erro, por favor tente novamente.';
    }

    return '';
  }

  void logOut() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}
