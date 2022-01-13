import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

AppBar appBarCheckout() {
  return AppBar(
    elevation: 0,
    centerTitle: false,
    title: Text(
      'Pagamento',
      style: Get.textTheme.headline1!.copyWith(fontSize: 25),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(FontAwesomeIcons.search),
      ),
    ],
  );
}