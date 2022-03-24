import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/stores/store_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';

class ListStores extends StatelessWidget {
  final StoreController controller = Get.put(StoreController());

  ListStores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildRow(String lojaNome, String lojaCEP, String lojaGUID) {
      return ListTile(
        leading: FadeInImage.assetNetwork(
          placeholder: 'assets/images/pholder.png',
          image: 'assets/images/pholder.png',
          imageErrorBuilder: (context, url, error) =>
              new Icon(Icons.local_offer_outlined),
          height: 10,
          fit: BoxFit.fitHeight,
        ),
        onTap: () => Get.toNamed(AppRoutes.store, arguments: [
          {'storeGuid': lojaGUID}
        ]),
        title: Text(
          lojaNome,
          // style: _biggerFont,
        ),
        subtitle: Text(lojaCEP),
        //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
      );
    }

    return FutureBuilder(
        future: controller.carregaLojas(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          } else {
            print('qt lojas: ' + controller.lojas.length.toString());
            return SingleChildScrollView(
                child: GradientHeaderHome(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                  SizedBox(height: 20),
                  Center(child: Text("Minhas lojas")),
                  SizedBox(height: 20),
                  ButtonOffer(
                    onPressed: () {
                      Get.toNamed(AppRoutes.store);
                    },
                    colorText: AppColors.primaryBackground,
                    text: 'Criar loja',
                    colorButton: AppColors.primaryColor,
                  ),
                  Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //scrollDirection: Axis.vertical,
                      // padding: const EdgeInsets.all(16.0),
                      itemCount: controller.lojas.length,
                      itemBuilder: (BuildContext context, int index) {
                        //if (index.isOdd) return const Divider();
                        //index = index ~/ 2 + 1;
                        Lojas retLoja = controller.lojas[index];
                        return _buildRow(retLoja.LojaNome!, retLoja.LojaCEP!,
                            retLoja.LojaGUID!);
                      },
                    ),
                  )
                ])));
          }
        });
  }
}
