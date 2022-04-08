import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';

import '../categories_controller.dart';
import 'list_vertical_categories.dart';

class BodyCategories extends StatelessWidget {
  final CategoriesController _controller = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as OffersArgs;
    //print('chave: ' + chave);

    return SingleChildScrollView(
      child: GradientHeaderHome(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Center(child: Text("Categorias",style: TextStyle(fontSize: 24),)),
            const SizedBox(height: 5),
            ListVerticalCategories(controller: _controller)
          ],
        ),
      ),
    );
  }
}
