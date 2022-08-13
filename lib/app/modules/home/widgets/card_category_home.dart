import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class CardCategories extends StatelessWidget {
  final String text;
  final IconData iconData;
  final String chave;

  const CardCategories({Key? key, required this.text, required this.iconData, required this.chave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    LoginController _loginController = Get.find();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Card(
            elevation: 5,
            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
            shape: CircleBorder(),
            child: Container(
              //color: Colors.grey,
              height: Get.height * 0.07,
              width: Get.width * 0.14,
              child: IconButton(icon: Icon(iconData), color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                onPressed: () {
                  OffersController offersController = Get.find();
                  Future.wait([offersController.getOfferByCEPCategory(chave.toString())]);

                  Get.toNamed(AppRoutes.offers, arguments: [
                    {'listName': null},
                    {'limit': 24},
                    {'category': chave.toString()},
                    {'title': 'Categorias'},
                    {'ofertaGuid': null}
                  ]);
                }
                ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.22,
            child: AutoSizeText(
              text,
              style: TextStyle(
                color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
