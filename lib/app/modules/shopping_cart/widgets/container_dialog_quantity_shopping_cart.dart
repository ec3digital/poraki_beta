
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../theme/app_theme.dart';

import '../shopping_cart_controller.dart';

class ContainerDialogShoppingCart extends StatelessWidget {
  const ContainerDialogShoppingCart({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ShoppingCartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(left: Get.width * 0.24),
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 04),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(07),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '1',
            style: Get.textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 05),
          GestureDetector(
            onTap: controller.showDialog,
            child: Icon(Icons.keyboard_arrow_down_outlined),
          )
        ],
      ),
    );
  }
}