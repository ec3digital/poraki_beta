import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_theme.dart';
import '../home/widgets/drawer_home.dart';
import 'shopping_cart_controller.dart';
import 'widgets/body_shopping_cart.dart';
import 'widgets/tab_bar_shopping_cart.dart';

class ShoppingCartPage extends StatelessWidget {
  ShoppingCartPage({
    Key? key,
  }) : super(key: key);

  final ShoppingCartController controller = Get.put(ShoppingCartController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.grayLightContainer,
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, Get.height * 0.14),
          child: TabBarShoppingCart(controller),
        ),
        drawer: DrawerHome(-1),
        body: TabBarView(
          children: [
            BodyShoppingCart(controller),
            Center(
              child: Text('Salvos'),
            )
          ],
        ),
      ),
    );
  }
}