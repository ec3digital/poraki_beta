import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ButtonOffer extends StatelessWidget {
  final String text;
  final Color? colorButton;
  final Color colorText;
  final VoidCallback onPressed;
  final bool isWhatsapp;

  const ButtonOffer({
    Key? key,
    required this.text,
    this.colorButton,
    required this.colorText,
    required this.onPressed,
    this.isWhatsapp = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: isWhatsapp ? Color.fromRGBO(18, 140, 126, 1.0) : colorButton),
        onPressed: onPressed,
        child: Text(
          text,
          style: Get.textTheme.bodyLarge!.copyWith(
              fontSize: 18, color: colorText, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
