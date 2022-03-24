import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_theme.dart';
import '../shopping_cart_controller.dart';

class DialogAmountShoppingCart extends StatelessWidget {
  DialogAmountShoppingCart(this.controller,{Key? key, }) : super(key: key);

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 08),
            TextAmountDialog(text: '1 unidade', onTap: () {}),
            TextAmountDialog(text: '2 unidades', onTap: () {}),
            TextAmountDialog(text: '3 unidades', onTap: () {}),
            TextAmountDialog(text: '4 unidades', onTap: () {}),
            TextAmountDialog(text: '5 unidades', onTap: () {}),
            TextAmountDialog(text: '6 unidades', onTap: () {}),
            GestureDetector(
              onTap: controller.showDialogMoreUnitys,
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.only(top: 05, bottom: 15),
                child: Text(
                  'Mais de 6 unidades',
                  textAlign: TextAlign.center,
                  style: Get.textTheme.bodyText1!
                      .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextAmountDialog extends StatelessWidget {
  final String text;
  final Function() onTap;

  const TextAmountDialog({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(top: 05, bottom: 05),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
