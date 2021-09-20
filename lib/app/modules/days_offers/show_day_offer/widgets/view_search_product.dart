import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../theme/app_theme.dart';

class ViewSearchProduct extends StatelessWidget {
  const ViewSearchProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Busca em PorAki',
            hintStyle: Get.textTheme.bodyText1!.copyWith(
              fontSize: 14,
              color: AppColors.black54Text,
            ),
            border: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
