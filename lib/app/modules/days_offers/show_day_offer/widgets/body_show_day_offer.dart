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
import 'name_product_offer_day.dart';
import 'text_price_product_day_offer.dart';

class BodyShowDayOffer extends StatelessWidget {
   BodyShowDayOffer({Key? key}) : super(key: key);

  final ShowDayOfferController _controller = Get.put(ShowDayOfferController());

  @override
  Widget build(BuildContext context) {
    final ProdutoOferta? _product = _controller.offerTapped;
    debugPrint(_product!.ofertaTitulo.toString());
    return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameProductOfferDay(
                nameProduct:
                _product.ofertaTitulo.toString()
                    //'Samsung Galaxy M21s Dual SIM 64 GB preto 4 GB RAM',
              ),
              const SizedBox(height: 10),
              ListPictureProduct(controller: _controller),
              const SizedBox(height: 15),
              DetailOfferDay(detailProduct: _product.ofertaDetalhe),
              SizedBox(height: 10),
              TextPriceProductDayOffer(textPrice: 'R\$ ' + _product.ofertaPreco.toString()),
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
                colorButton: AppColors.grayBlueButton,
              ),
            ],
          ),
        ),
      );
  }
}
