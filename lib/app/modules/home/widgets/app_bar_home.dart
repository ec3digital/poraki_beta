import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
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
      backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
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
                  color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextFormField(
                  onFieldSubmitted: (String value) {
                    Get.toNamed(AppRoutes.offers, arguments: [
                      {'listName': null}, {'limit': 24}, {'category': null }, {'title': txtBuscaCtrl.text.trimRight()}, {'ofertaGuid': null}] );
                  } ,
                  controller: txtBuscaCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    labelText: _loginController.listCore.where((coreItem) => coreItem.coreChave == 'textSearch').first.coreValor.toString(),

                  ),
                ),
              ),
            ),
            const SizedBox(width: 08),
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.shoppingCart),
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
