import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../../data/models/categorias.dart';
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
    LoginController _loginController = Get.find();
    return GetBuilder<HomeController>(
      builder: (_) {
        if (controller.isLoading) {
          return CircularProgressIndicator.adaptive();
        }
        return Container(
          height: Get.height * 0.14,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _loginController.categorias.length,
            itemBuilder: (BuildContext context, int index) {
              Categorias categories = _loginController.categorias[index];
              //print('iconcode: ' + categories.categoriaChave.toString() + ' / ' + categories.iconcode.toString());
              return CardCategories(
                text: categories.categoriaNome!,
                iconData: IconData(int.parse(categories.iconcode.toString()), fontFamily: 'MaterialIcons'),
                // iconData: IconData(0xf184,fontFamily: 'MaterialIcons'),
                chave: categories.categoriaChave!,
                // iconData: Icons.image_outlined,
              );
            },
          ),
        );
      },
    );
  }
}
