import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/categories/categories_controller.dart';
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
    final CategoriesController _categoriesController = Get.put(CategoriesController());
    var horizList = [];
    var listQtdCategsNomes = [];

    // traz somente as categorias que tenham algum item
    //_categoriesController.getQtyCategs();
    _categoriesController.qtdCategs.forEach((element) { listQtdCategsNomes.add(element.CategoriaChave.toString());});
    _loginController.listaCategorias.forEach((element) {
       if(listQtdCategsNomes.contains(element.categoriaChave))
        horizList.add(element);
     });

    return GetBuilder<HomeController>(
      builder: (_) {
        if (controller.isLoading) {
          return CircularProgressIndicator.adaptive();
        }
        return Container(
          height: Get.height * 0.14,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: horizList.length,
            itemBuilder: (BuildContext context, int index) {
              // Categorias categories = _loginController.listaCategorias.where((element) => element.mostraBarra == true).toList()[index];
              Categorias categories = horizList[index];
              return CardCategories(
                text: categories.categoriaNome!,
                iconData: IconData(int.parse(categories.iconcode.toString()), fontFamily: 'MaterialIcons'),
                chave: categories.categoriaChave!,
              );
            },
          ),
        );
      },
    );
  }
}
