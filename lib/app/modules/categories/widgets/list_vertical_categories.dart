import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
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
    final LoginController _loginController = Get.find();
    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());
    var categoriasBarra = controller.categorias.where((element) => element.mostraBarra == true).toList(); //.sort((o1,o2) => o1.or);

    Widget _buildRow(
        int idx, String categoryName, String chave, String iconcode) {
      return ListTile(
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
              padding: const EdgeInsets.all(6.0),
              itemCount: categoriasBarra.length,
              itemBuilder: (BuildContext context, int index) {
                //if (index.isOdd) return const Divider();
                //index = index ~/ 2 + 1;
                Categorias categories = categoriasBarra[index];

                return Container(
                    padding: const EdgeInsets.all(5),
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
            ),
          );
        }
      },
    );
  }
}
