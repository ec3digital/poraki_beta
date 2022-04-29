import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

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
        child:
        CarouselSlider(options: CarouselOptions(height: 140.0, autoPlay: true,),
          items: controller.listBanners.map((item) => Container(
            child: Container(
                  margin: EdgeInsets.only(left: 4, right: 4),
                  width: Get.width * 0.98,
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                child: Image.network(item, fit: BoxFit.cover, width: Get.width,))),
          ))
              .toList(),
        )
    );
  }
}
