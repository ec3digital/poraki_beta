import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/shopping_cart/widgets/app_cart.dart';
import '../../theme/app_theme.dart';
import 'shopping_cart_controller.dart';
import 'widgets/body_shopping_cart.dart';

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
        backgroundColor: AppColors.containerLightColor,
        appBar: appBarCart(),
       // drawer: DrawerHome(-1),
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
