import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/stores/store_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';

class ListStores extends StatelessWidget {
  ListStores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreController controller = Get.find(); //.put(StoreController());

    Widget _buildRow(Lojas loja) {
      return ListTile(
          leading: Text(
            loja.LojaNome.toString(),
            // style: _biggerFont,
          ),
          onTap: () {
            controller.loja = loja;
            Get.toNamed(AppRoutes.store);
          },
          title: Text(
            loja.LojaCEP.toString(),
            // style: _biggerFont,
          )
          //   subtitle: Text(lojaCEP),
          //   //trailing: Icon(IconData(int.parse(iconcode), fontFamily: 'MaterialIcons'))
          // );
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
            return Container(
              child: GetBuilder<StoreController>(builder: (context) {
                if (controller.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
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
                            Future.delayed(Duration.zero, () async {
                              controller.emptyLoja();
                            });
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
                              return _buildRow(retLoja);
                            },
                          ),
                        )
                      ])));
                }
              }),
            );
          }
        });
  }
}
