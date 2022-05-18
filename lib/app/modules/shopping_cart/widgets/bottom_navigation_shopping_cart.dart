import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../shopping_cart_controller.dart';

class BottomNavigationShoppingCart extends StatefulWidget {
  BottomNavigationShoppingCart({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationShoppingCart> createState() =>
      _BottomNavigationShoppingCartState();
}

class _BottomNavigationShoppingCartState
    extends State<BottomNavigationShoppingCart> {
  late String cepAtual;

  // Future<void> getEnderecoAtual() async {
  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color darkText = _loginController.colorFromHex(_loginController.listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    ShoppingCartController controller = Get.find();

    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 4,
      child: Container(
        width: Get.width,
        height: Get.height * 0.30,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  Text(
                    'Envio: ',
                    style: TextStyle(color: darkText, fontSize: 15),
                  ),
                  Text(
                    _loginController.usuCep.toString(),
                    // 'Rua tal com tal coisa 85, São Paulo',
                    style: TextStyle(color: darkText, fontSize: 15),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(color: darkText, fontSize: 16),
                  ),
                  Obx(() => Text(
                        'R\$ ' +
                            controller.cartTotalItems.value
                                .toStringAsFixed(2)
                                .replaceAll(',', '')
                                .replaceAll('.', ','),
                        style: TextStyle(color: darkText, fontSize: 16),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: Get.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ButtonOffer(
                      onPressed: () {
                        Get.toNamed(AppRoutes.checkout);
                      },
                      text: 'Pagar',
                      colorText: _loginController.colorFromHex(_loginController
                          .listCore
                          .where(
                              (coreItem) => coreItem.coreChave == 'textLight')
                          .first
                          .coreValor
                          .toString()),
                      colorButton: _loginController.colorFromHex(
                          _loginController.listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'iconColor')
                              .first
                              .coreValor
                              .toString()),
                    ),
                    ButtonOffer(
                      onPressed: () {
                        final ShoppingCartController controller = Get.find();
                        controller.esvaziaCarrinho();
                        Navigator.pop(context);
                      },
                      text: 'Esvaziar o carrinho',
                      colorText: darkText,
                      colorButton: _loginController.colorFromHex(
                          _loginController.listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'backDark')
                              .first
                              .coreValor
                              .toString()),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
