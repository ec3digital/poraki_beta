import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:poraki/app/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class LoginService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();

  get currentUserObject => null;

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

    print(response.body);
  }

  Future<String> loginWithEmailAndPassword(
      String email, String password) async {
    // late Map<String, User?>? retErro;// = [] as Map<String, User?>?;
    try {
      // Sign in the user on firebase with provided username and password
      await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final currentUserObject = auth.FirebaseAuth.instance.currentUser;

      if (currentUserObject?.uid != null) {
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

      return 'Ops, ocorreu um erro inesperado. Por favor tente novamente';
    } catch (e, s) {
      //print(e.toString() + '$s');
      return 'Ocorreu um erro, por favor tente novamente.';
    }

    return '';
  }

  void logOut() async {
    await auth.FirebaseAuth.instance.signOut();
  }
}
