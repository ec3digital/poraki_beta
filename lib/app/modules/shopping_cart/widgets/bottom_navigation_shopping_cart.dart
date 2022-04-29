import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../theme/app_theme.dart';
import '../shopping_cart_controller.dart';

class BottomNavigationShoppingCart extends StatelessWidget {
  BottomNavigationShoppingCart({
    Key? key,
  }) : super(key: key);

  late String cepAtual;

  Future<void> getEnderecoAtual() async {
    cepAtual = await AddressController().getCepAtualCloud().toString();
  }

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    Color darkText = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString());
    double total = 200.00;

    return FutureBuilder(
        future: getEnderecoAtual(),
        builder: (context, futuro) {
          if (futuro.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); //Text('carrinho vazio'));
            // } else if (futuro.hasError) {
            //   return Center(child: Text(futuro.error.toString()));
          }
          else {
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
                            cepAtual,
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
                          Text('Total', style: TextStyle(color: darkText, fontSize: 16),),
                          Text('R\$ ' + total.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ','), style: TextStyle(color: darkText, fontSize: 16),),
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
                              colorText: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                              colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
                            ),
                            ButtonOffer(
                              onPressed: () {
                                final ShoppingCartController controller = Get
                                    .find();
                                controller.esvaziaCarrinho();
                                // controller.carregaCarrinho();
                                Navigator.pop(context);
                              },
                              text: 'Esvaziar o carrinho',
                              colorText: darkText,
                              colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}
