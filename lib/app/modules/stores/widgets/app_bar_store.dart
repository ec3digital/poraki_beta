import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

AppBar appBarStore() {
  LoginController _loginController = Get.find();

  return AppBar(
    elevation: 0,
    centerTitle: false,
    backgroundColor: _loginController.colorFromHex(_loginController.backLight),
    title: Text(
      'Loja',
      style: TextStyle(
          fontSize: 25,
          color: _loginController.colorFromHex(_loginController.textDark)),
    ),
  );
}
