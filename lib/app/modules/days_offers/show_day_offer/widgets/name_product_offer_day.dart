import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameProductOfferDay extends StatelessWidget {

  final String nameProduct;

  const NameProductOfferDay({Key? key, required this.nameProduct,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        nameProduct,
        textAlign: TextAlign.start,
        style: Get.textTheme.bodyText1!
            .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}