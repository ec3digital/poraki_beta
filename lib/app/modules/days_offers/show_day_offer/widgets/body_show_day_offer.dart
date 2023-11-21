import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import '../../../../theme/app_theme.dart';
import '../show_day_offer_controller.dart';
import 'button_day_offer.dart';
import 'container_amount_product_day_offer.dart';
import 'container_detail_day_offer.dart';
import 'list_picture_product_day_offer.dart';
import 'text_price_product_day_offer.dart';

class BodyShowDayOffer extends StatelessWidget {
  BodyShowDayOffer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShowDayOfferController _controller = Get.find();
    LoginController _loginController = Get.find();

    return Container(
        child: GetBuilder<ShowDayOfferController>(builder: (context) {
          if (_controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            ProdutoOferta? _product = _controller.offerTapped;
            List<String> offersImages = [];
            offersImages.add(
                _loginController.imgPath + _product!.ofertaGUID.toString() + _loginController.imgPathSuffix);

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NameProductOfferDay(
                    //     nameProduct:
                    //     _product!.ofertaTitulo.toString()
                    //   //'Samsung Galaxy M21s Dual SIM 64 GB preto 4 GB RAM',
                    // ),
                    const SizedBox(height: 10),
                    ListPictureProduct(controller: _controller),
                    const SizedBox(height: 15),
                    DetailOfferDay(
                        detailProduct: _product.ofertaDetalhe.toString()),
                    SizedBox(height: 10),
                    TextPriceProductDayOffer(
                        textPrice: _product.ofertaPreco! > 0 ? 'R\$ ${_product.ofertaPreco!.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',')}' : 'à combinar',
                    ),
                    const SizedBox(height: 10),
                    ContainerAmountProductDayOffer(),
                    SizedBox(height: 10),
                    ButtonsDayOffer(
                      onPressed: () {},
                      colorText: _loginController.colorFromHex(_loginController.backLight),
                      text: 'Comprar agora',
                      colorButton: AppColors.primaryColor,
                    ),
                    ButtonsDayOffer(
                      onPressed: () {},
                      colorText: AppColors.primaryColor,
                      text: 'Adicionar ao carrinho',
                      colorButton: AppColors.primaryColorButton,
                    ),
                  ],
                ),
              ),
            );
          }
        }
        )
    );
  }
}

