import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/stores/store_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';

class ListStores extends StatelessWidget {
  ListStores({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StoreController controller = Get.put(StoreController());
    final LoginController _loginController = Get.find();

    Widget _buildRow(Lojas loja) {
      return Column(children: [
        ListTile(
            leading: Text(
              loja.LojaNome.toString(),
            ),
            onTap: () {
              controller.loja = loja;
              Get.toNamed(AppRoutes.store);
            },
            title: Text(
              loja.LojaCEP.toString(),
            )),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
      ]);
    }

    // return FutureBuilder(
    //     future: _loginController.listLojas,
    //     builder: (context, futuro) {
    //       if (futuro.connectionState == ConnectionState.waiting) {
    //         return Center(
    //             child: CircularProgressIndicator()); //Text('carrinho vazio'));
    //         // } else if (futuro.hasError) {
    //         //   return Center(child: Text(futuro.error.toString()));
    //       } else {
    //         print('qt lojas: ' + controller.lojas.length.toString());
    return Container(
      child: GetBuilder<StoreController>(builder: (context) {
        return SingleChildScrollView(
            child: GradientHeaderHome(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                colorText: _loginController.colorFromHex(_loginController
                    .listCore
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
              Scrollbar(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  //scrollDirection: Axis.vertical,
                  // padding: const EdgeInsets.all(16.0),
                  itemCount: _loginController.listLojas.length,
                  itemBuilder: (BuildContext context, int index) {
                    //if (index.isOdd) return const Divider();
                    //index = index ~/ 2 + 1;
                    Lojas retLoja = _loginController.listLojas[index];
                    return _buildRow(retLoja);
                  },
                ),
              )
            ])));
      }),
    );
  }
}
