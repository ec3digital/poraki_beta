import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/login_model.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/constants/preferences_keys.dart';

class SignUpController extends GetxController {
  TextEditingController nameInputController = TextEditingController();
  TextEditingController mailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController confirmInputController = TextEditingController();

  bool showPassword = false;
  final formKey = GlobalKey<FormState>();

  signUp(String email, String password) async {
    http.Response response = await http.post(
      Uri.parse(AppRoutes.signIn),
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

  void doSignUp() {
    if (formKey.currentState!.validate()) {
      SignUpController().signUp(
        mailInputController.text,
        passwordInputController.text,
      );
    } else {
      print("invalido");
    }
    // LoginModel newUser = LoginModel(
    //   name: _nameInputController.text,
    //   mail: _mailInputController.text,
    //   password: _passwordInputController.text,
    //   keepOn: true,
    // );
    // _saveUser(newUser);
  }

  void changeShowPassword(bool newValue) {
    showPassword = newValue;
    update();
  }

  // ignore: unused_element
  void _saveUser(LoginModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      PreferencesKeys.activeUser,
      json.encode(user.toJson()),
    );
  }
}
