import 'package:flutter/material.dart';
import '../shopping_cart_controller.dart';
import 'list_shopping_cart.dart';

import 'bottom_navigation_shopping_cart.dart';

class BodyShoppingCart extends StatelessWidget {
  BodyShoppingCart(this.controller,{Key? key, }) : super(key: key);

  final ShoppingCartController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListShoppingCart(controller: controller),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationShoppingCart(),
    );
  }
}
