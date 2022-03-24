import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlEndereco.dart';
import 'package:poraki/app/modules/addresses/address_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../../../theme/app_theme.dart';
import '../shopping_cart_controller.dart';

class BottomNavigationShoppingCart extends StatelessWidget {
  BottomNavigationShoppingCart({
    Key? key,
  }) : super(key: key);

  late sqlEndereco endAtual;
  late double total;

  Future<void> getEnderecoAtual() async {
    endAtual = await AddressController().EnderecoAtual();
    total = 200.00;
  }

  @override
  Widget build(BuildContext context) {
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
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            endAtual.enderecoCEP,
                            // 'Rua tal com tal coisa 85, São Paulo',
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
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
                          Text('Total'),
                          Text('R\$ ' + total.toString()),
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
                              colorText: Colors.white,
                              colorButton: Colors.brown,
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
                              colorText: AppColors.primaryColor,
                              colorButton: AppColors.primaryColorButton,
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
