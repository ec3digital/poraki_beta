import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/stores/store_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListStores extends StatelessWidget {
  ListStores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreController controller = Get.put(StoreController());
    final LoginController _loginController = Get.find();
    final Color backColor = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    Widget _buildRow(Lojas loja) {
      return Column(children: [
        ListTile(
            leading:
            CachedNetworkImage(
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/lojas%2F' +
      loja.LojaGUID.toString() +
          '.jpg?alt=media',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                      value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  Icon(Icons.local_offer_outlined),
              height: 160,
            ),


            onTap: () {
              controller.loja = loja;
              Get.toNamed(AppRoutes.store);
            },
            title: Text(
              loja.LojaNome.toString(),
                style: TextStyle(fontSize: 18),
            ),
          subtitle: Text("CEP - " +
              loja.LojaCEP.toString(),
              style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(height: 5),

      ]);
    }

    return GetBuilder<StoreController>(builder: (context) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 15),
            Center(
                child: Text(
              "Minhas lojas",
              style: TextStyle(fontSize: 24),
            )),
            const SizedBox(height: 15),
            ButtonOffer(
              onPressed: () {
                Future.delayed(Duration.zero, () async {
                  controller.emptyLoja();
                });
                Get.toNamed(AppRoutes.store);
              },
              colorText: _loginController.colorFromHex(_loginController.listCore
                  .where((coreItem) => coreItem.coreChave == 'textLight')
                  .first
                  .coreValor
                  .toString()),
              text: 'Criar Loja',
              colorButton: _loginController.colorFromHex(_loginController
                  .listCore
                  .where((coreItem) => coreItem.coreChave == 'textDark')
                  .first
                  .coreValor
                  .toString()),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(6.0),
                itemCount: _loginController.listLojas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: backColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: backColor,
                      ),
                      child: _buildRow(_loginController.listLojas[index]));
                },
              ),
            ))
          ]);
    });
  }
}
