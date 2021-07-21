import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poraki/app/data/models/categorias.dart';

import '../home_controller.dart';
import 'card_category_home.dart';

class ListHorizontalCategoriesHome extends StatelessWidget {
  final HomeController controller;
  const ListHorizontalCategoriesHome({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        if (controller.isLoading) {
          return CircularProgressIndicator.adaptive();
        }
        return Container(
          height: Get.height * 0.14,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categorias!.length,
            itemBuilder: (BuildContext context, int index) {
              Categorias categoria = controller.categorias![index];
              return CardCategories(
                text: categoria.categoriaNome!,
                iconData: Icons.image_outlined,
              );
            },
          ),
        );
      },
    );
  }
}
