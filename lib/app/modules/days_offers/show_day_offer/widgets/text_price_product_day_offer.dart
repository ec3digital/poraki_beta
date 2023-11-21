import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';

class TextPriceProductDayOffer extends StatelessWidget {

  final String textPrice;

  const TextPriceProductDayOffer({Key? key, required this.textPrice,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return Text(
      textPrice,
      style: TextStyle(
        fontSize: 25,
        color: _loginController.colorFromHex(_loginController.backLight)
      ),
    );
  }
}
