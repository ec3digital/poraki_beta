import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
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
    final ShowDayOfferController _controller = Get.find(); // Get.put(ShowDayOfferController());
    _controller.getOfferTapped(3);
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
                'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                    _product!.ofertaID.toString() +
                    '.jpg?alt=media');

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
                        textPrice: 'R\$ ${_product.ofertaPreco!.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 10),
                    ContainerAmountProductDayOffer(),
                    SizedBox(height: 10),
                    ButtonsDayOffer(
                      onPressed: () {},
                      colorText: Colors.white,
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

