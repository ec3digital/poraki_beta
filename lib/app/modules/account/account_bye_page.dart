import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/auth/login/login_page.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';

class AccountByePage extends StatelessWidget {
  AccountByePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    Color textDark = _loginController.colorFromHex(_loginController.textLight);

    return Scaffold(
        backgroundColor: _loginController.colorFromHex(_loginController.backDark),
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 140,
                ),
                Center(
                    child: Text(
                        'Uma pena voce ter nos deixado agora... esperamos que volte em breve',
                        style: TextStyle(fontSize: 25))),
                const SizedBox(
                  height: 40,
                ),
                ButtonOffer(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  colorText: textDark,
                  text: 'Tchau',
                  colorButton: _loginController.colorFromHex(_loginController.textDark),
                ),
              ],
            )));
  }
}
