import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../data/models/categorias.dart';
import '../categories_controller.dart';

class ListVerticalCategories extends StatelessWidget {
  final CategoriesController controller;
  const ListVerticalCategories({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildRow(int idx, String categoryName, String chave, String iconcode) {
      return ListTile(
        leading: Icon(IconData(0xf184,fontFamily: 'MaterialIcons')), //Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons')),
        onTap: () => Get.toNamed(AppRoutes.offers, arguments: [
          {'listName': null}, {'limit': 24}, {'category': chave.toString() }, {'title': null}, {'ofertaGuid': null}] ),
        title: Text(
          categoryName,
          // style: _biggerFont,
        ),
         //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
      );
    }

    return GetBuilder<CategoriesController>(
      builder: (_) {
        if (controller.isLoading) {
          return CircularProgressIndicator.adaptive();
        } else {
        return Container(
          // height: Get.height * 50, // * 0.14,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.categorias!.length,
            itemBuilder: (BuildContext context, int index) {
              //if (index.isOdd) return const Divider();
               //index = index ~/ 2 + 1;
              Categorias categories = controller.categorias![index];
              return _buildRow(index, categories.categoriaNome.toString(), categories.categoriaChave.toString(), categories.iconcode.toString());
            },
          ),
        );
      }},
    );
  }
}
