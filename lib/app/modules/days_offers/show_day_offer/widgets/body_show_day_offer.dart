import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  final ShowDayOfferController controller = Get.put(ShowDayOfferController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameProductOfferDay(
                nameProduct:
                    'Samsung Galaxy M21s Dual SIM 64 GB preto 4 GB RAM',
              ),
              const SizedBox(height: 10),
              ListPictureProduct(controller: controller),
              const SizedBox(height: 15),
              DetailOfferDay(detailProduct: 'Várias peças - 6 anos de idade'),
              SizedBox(height: 10),
              TextPriceProductDayOffer(textPrice: 'R\$ 1.399 '),
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
