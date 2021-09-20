import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class ListHorizontalBannersHome extends StatelessWidget {
  final HomeController controller;
  const ListHorizontalBannersHome({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.listBanners.length,
        itemBuilder: (context, index) {
          String imgBanner = controller.listBanners[index];

          return Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: Get.width * 0.95,
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imgBanner,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
