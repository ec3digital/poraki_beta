import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../home_controller.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    var txtBuscaCtrl = TextEditingController();

    return AppBar(
      backgroundColor: Colors.amber,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextFormField(
                  onFieldSubmitted: (String value) {
                    Get.toNamed(AppRoutes.offers, arguments: [
                      {'cep': '05735030'}, {'category': null }, {'title': txtBuscaCtrl.text}] );
                  } ,
                  controller: txtBuscaCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Poraki você busca por...',

                  ),
                ),
              ),
            ),
            const SizedBox(width: 08),
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.offers, arguments: [
                {'cep': '05735030'}, {'category': null }, {'title': txtBuscaCtrl.text}] ),
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
