import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

AppBar appBarOffers(String? titulo) {
  LoginController _loginController = Get.find();

  return AppBar(
    elevation: 0,
    centerTitle: false,
    backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString()),
    title: Text(
      titulo == null ? 'Ofertas' : titulo,
      style: TextStyle(fontSize: 25,
      color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
      ) // Get.textTheme.headline1!.copyWith(fontSize: 25),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.search),
      ),
    ],
  );
}
