import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/offers/widgets/detail_offer.dart';
import 'package:poraki/app/theme/app_theme.dart';
import '../../../data/models/produto_oferta.dart';
import '../offers_controller.dart';
import 'list_pics_offer.dart';

// ignore: must_be_immutable
class BodyOffer extends StatelessWidget {
  final int offerId;
  BodyOffer({Key? key, required this.offerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //OffersController offersController = Get.put(OffersController());
    OffersController offersController = Get.find();
    return Container(
        child: GetBuilder<OffersController>(builder: (context) {
          if (offersController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {

            //offersController.getOfferById(4);
            ProdutoOferta _product = offersController.offers.where((p) => p.ofertaID == this.offerId).first;
            print('body_offer - ' + offersController.offers.length.toString());
            List<String> offersImages = [];
            offersImages.add('https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                _product.ofertaID.toString() +
                '.jpg?alt=media');

            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _product.ofertaTitulo.toString(),
                    textAlign: TextAlign.start,
                    style: Get.textTheme.bodyText1!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
                    const SizedBox(height: 10),
                    ListPicsOffer(imagesList: offersImages),
                    const SizedBox(height: 15),
                    DetailOffer(detailProduct: _product.ofertaDetalhe),
                    SizedBox(height: 10),
                    Text(
                        'R\$ ' + _product.ofertaPreco.toString(),
                        style: Get.textTheme.bodyText1!.copyWith(
                          fontSize: 25,
                        ),),
                    const SizedBox(height: 10),
                    Text('Quantidade: 1'),
                    SizedBox(height: 10),
                    ButtonOffer(
                      onPressed: () {},
                      colorText: Colors.white,
                      text: 'Comprar agora',
                      colorButton: AppColors.primaryColor,
                    ),
                    ButtonOffer(
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
        }),
    );
  }
}
