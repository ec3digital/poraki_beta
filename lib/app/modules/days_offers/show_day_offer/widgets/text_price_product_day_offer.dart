import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextPriceProductDayOffer extends StatelessWidget {

  final String textPrice;

  const TextPriceProductDayOffer({Key? key, required this.textPrice,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textPrice,
      style: Get.textTheme.bodyText1!.copyWith(
        fontSize: 25,
      ),
    );
  }
}
