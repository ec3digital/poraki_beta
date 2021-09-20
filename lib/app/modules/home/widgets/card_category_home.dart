import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardCategories extends StatelessWidget {
  final String text;
  final IconData iconData;

  const CardCategories({Key? key, required this.text, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Card(
            elevation: 1,
            color: Colors.white,
            shape: CircleBorder(),
            child: Container(
              //color: Colors.grey,
              height: Get.height * 0.07,
              width: Get.width * 0.14,
              child: Icon(iconData),
            ),
          ),
          SizedBox(
            width: Get.width * 0.22,
            child: AutoSizeText(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
