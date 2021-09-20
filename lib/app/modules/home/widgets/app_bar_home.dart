import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../shopping_cart/shopping_cart_page.dart';
import '../home_controller.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 0,
      titleSpacing: 0,
      title: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Poraki você busca...',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 08),
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.viewSearchProduct),
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
