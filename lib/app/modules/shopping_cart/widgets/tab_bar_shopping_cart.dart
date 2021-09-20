import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../days_offers/show_day_offer/widgets/view_search_product.dart';
import '../shopping_cart_controller.dart';
import '../../../theme/app_theme.dart';

class TabBarShoppingCart extends StatelessWidget {
  TabBarShoppingCart(
    this.controller, {
    Key? key,
  }) : super(key: key);

  final ShoppingCartController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () => Get.toNamed(AppRoutes.viewSearchProduct),
          icon: Icon(Icons.search),
        )
      ],
      backgroundColor: AppColors.yellowComum,
      bottom: TabBar(
        indicatorColor: Colors.black,
        tabs: [
          Text(
            'Carrinho(${controller.listShoppingCart.length})',
            style: Get.textTheme.bodyText1!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            'Salvos',
            style: Get.textTheme.bodyText1!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
