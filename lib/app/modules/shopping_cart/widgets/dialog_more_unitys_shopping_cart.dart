import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shopping_cart_controller.dart';
import '../../../theme/app_theme.dart';

class DialogMoreUnitysShoppingCart extends StatelessWidget {
  const DialogMoreUnitysShoppingCart(
    this.controller, {
    Key? key,
  }) : super(key: key);

  final ShoppingCartController controller;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      title: Container(
        height: Get.height * 0.10,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(08),
            topRight: Radius.circular(08),
          ),
          color: AppColors.containerLightColor,
        ),
        child: Center(
          child: Text(
            'Quantidade',
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyText1!
                .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              onChanged: controller.changeMoreQuantity,
              decoration: InputDecoration(hintText: 'Digite a quantidade'),
            ),
            const SizedBox(height: 20),
            GetBuilder<ShoppingCartController>(builder: (_) {
              return Container(
                width: Get.width,
                child: ElevatedButton(
                  onPressed: controller.moreQuantity.length <= 0
                      ? null
                      : controller.cgsfgs,
                  child: Text('Confirmar'),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
