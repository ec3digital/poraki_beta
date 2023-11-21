import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'login/login_controller.dart';

class TermosPage extends StatelessWidget {
  final LoginController loginController =
      Get.find(); // Get.put(HomeController());
  TermosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        color: AppColors.secondaryBackground,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 10),
              Image.asset('assets/images/poraki250.png'),
              const SizedBox(height: 10),
              Text('Termos do Poraki',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: AppColors.darkText)),
              const SizedBox(height: 80),
              ButtonOffer(
                  text: 'Aceitar >>',
                  colorText: loginController.colorFromHex(loginController.textLight),
                  colorButton: loginController.colorFromHex(loginController.iconColor),
                  onPressed: () {
                    // TODO: salvar a data do aceite, versão e uid
                    Get.toNamed(AppRoutes.home);
                  }),
            ]));
  }
}
