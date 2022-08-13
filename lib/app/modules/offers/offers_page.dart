import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/widgets/app_offers.dart';
import 'package:poraki/app/modules/offers/widgets/body_offers.dart';

class OffersPage extends StatelessWidget {
  OffersPage({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return Scaffold(
      appBar: appBarOffers(Get.arguments[3]['title']),
      body: Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString()),
                  _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
                ],
              )),
          child: BodyOffers()),
      // backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),

    );
  }
}
