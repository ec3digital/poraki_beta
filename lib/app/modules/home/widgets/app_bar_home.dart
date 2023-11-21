import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../home_controller.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    var txtBuscaCtrl = TextEditingController();
    LoginController _loginController = Get.find();

    return AppBar(
      backgroundColor: _loginController.colorFromHex(_loginController.backDark),
      elevation: 0,
      titleSpacing: 0,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 34,
                decoration: BoxDecoration(
                  color: _loginController.colorFromHex(_loginController.textLight),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextFormField(
                  onFieldSubmitted: (String value) {
                    // Get.toNamed(AppRoutes.offers, arguments: [                      {'listName': null}, {'limit': 24}, {'category': null }, {'title': txtBuscaCtrl.text.trimRight()}, {'ofertaGuid': null}] );
                    OffersController offersController = Get.find();
                    Future.wait([offersController.getOfferByCEPTitle(value.trim())]);

                    Get.toNamed(AppRoutes.offers, arguments: [
                      {'listName': null},
                      {'limit': 24},
                      {'category': null},
                      {'title': value.trim()},
                      {'ofertaGuid': null},
                      // {'storeId': ''}
                    ]);

                  },
                  controller: txtBuscaCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    labelText: _loginController.textSearch,

                  ),
                ),
              ),
            ),
            const SizedBox(width: 08),
            IconButton(
              onPressed: () =>
                  Get.defaultDialog(
                      title: 'Aviso',
                      middleText: 'Em breve !'
                    //"Existem várias maneiras de ganhar prêmios no Poraki, através dos selos que voce conquista: \n\nSelo SUPER CONSUMIDOR\nvoce ganha este selo à partir de 20 compras realizadas através do aplicativo. \n\nSelo BOM VIZINHO\nvoce ganha este selo quando voce envia 10 avisos e que são validados por outro vizinho da sua região, ou quando você valida 20 avisos enviados por outros vizinhos. ",
                    //textConfirm: 'OK', onConfirm: () => Get.closeAllSnackbars()
                  ),
                  // Get.toNamed(AppRoutes.shoppingCart),
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
