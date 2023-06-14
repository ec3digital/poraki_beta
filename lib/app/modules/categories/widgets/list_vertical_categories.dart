import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../data/models/categorias.dart';
import '../categories_controller.dart';

class ListVerticalCategories extends StatelessWidget {
  //final CategoriesController controller;
  const ListVerticalCategories({
    Key? key,
    //required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();
    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());
    var categoriasAll =
        _loginController.listaCategorias.toList(); //.sort((o1,o2) => o1.or);

    Widget _buildRow(
        int idx, String categoryName, String chave, String iconcode) {
      return Column(children: [
        ListTile(
          leading: Icon(IconData(int.parse(iconcode),
              fontFamily:
                  'MaterialIcons')), //Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons')),
          onTap: () {
            OffersController offersController = Get.find();
            Future.wait(
                [offersController.getOfferByCEPCategory(chave.toString())]);

            Get.toNamed(AppRoutes.offers, arguments: [
              {'listName': null},
              {'limit': 24},
              {'category': chave.toString()},
              {'title': 'Categorias'},
              {'ofertaGuid': null}
            ]);
          },
          title: Text(
            categoryName,
            // style: _biggerFont,
          ),
          //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
        ),
        const SizedBox(height: 3)
      ]);
    }

    return GetBuilder<CategoriesController>(builder: (_) {
      //var h = MediaQuery.of(context).size.height;

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Center(
              child: Text(
            "Categorias",
            style: TextStyle(fontSize: 24),
          )),
          const SizedBox(height: 5),
          //maxHeight: h + 250,
          // height: Get.height * 50, // * 0.14,
          //height: MediaQuery.of(context).size.height,
          //constraints: BoxConstraints(maxHeight: h, minHeight: 56.0),
          Expanded(
              child: Container(
                  child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.all(6.0),
            itemCount: categoriasAll.length,
            itemBuilder: (BuildContext context, int index) {
              Categorias categories = categoriasAll[index];

              return Container(
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: backColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: backColor,
                  ),
                  //color: backColor,
                  child: _buildRow(
                      index,
                      categories.categoriaNome.toString(),
                      categories.categoriaChave.toString(),
                      categories.iconcode.toString()));
            },
          ))),
          //const SizedBox(height: 20),
        ],
      );
    });
  }
}
