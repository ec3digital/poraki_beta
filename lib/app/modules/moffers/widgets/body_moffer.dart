import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/oferta.dart';
import 'package:poraki/app/modules/moffers/moffer_controller.dart';
import 'package:poraki/app/modules/moffers/widgets/list_pics_moffer.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/offers/widgets/detail_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';

// ignore: must_be_immutable
class BodyMoffer extends StatelessWidget {
  final int offerGuid;
  BodyMoffer({Key? key, required this.offerGuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //OffersController offersController = Get.put(OffersController());
    MofferController moffersController = Get.find();
    return Container(
      child: GetBuilder<MofferController>(builder: (context) {
        if (moffersController.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //offersController.getOfferById(4);
          Oferta _moffer = moffersController.moffers
              .where((o) => o.OfertaGUID == this.offerGuid)
              .first;
          print('body_moffer - ' + moffersController.moffers.length.toString());
          List<String> offersImages = [];
          // offersImages.add(
          //     'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
          //         _moffer.OfertaGUID.toString() +
          //         '.jpg?alt=media');

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _moffer.OfertaTitulo.toString(),
                      textAlign: TextAlign.start,
                      style: Get.textTheme.bodyText1!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  // const SizedBox(height: 10),
                  // ListPicsMoffer(imagesList: offersImages),
                  const SizedBox(height: 15),
                  DetailOffer(detailProduct: _moffer.OfertaDetalhe),
                  SizedBox(height: 10),
                  Text(
                    'R\$ ${_moffer.OfertaPreco?.toStringAsFixed(2) ?? ''}',
                    style: Get.textTheme.bodyText1!.copyWith(
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Text('Quantidade: 1'),
                  // SizedBox(height: 10),
                  // ButtonOffer(
                  //   onPressed: () {
                  //     sqlPorakiCartService().insertItemCarrinho(new sqlCarrinho(
                  //         _moffer.OfertaID.toString(),
                  //         '', //ofertaGUID,
                  //         _moffer.OfertaTitulo.toString(),
                  //         _moffer.OfertaCEP.toString(),
                  //         '', //ofertaVendedorGUID,
                  //         _moffer.OfertaPreco.toString(),
                  //         '1', //ofertaQtd,
                  //         _moffer.OfertaImgPath.toString(),
                  //         _moffer.CategoriaChave.toString(),
                  //         DateTime.now().add(new Duration(hours: 1)).toString() // adiciona 1h
                  //     ));
                  //
                  //     Get.toNamed(AppRoutes.shoppingCart);
                  //   },
                  //   colorText: Colors.white,
                  //   text: 'Comprar agora',
                  //   colorButton: AppColors.primaryColor,
                  // ),
                  // ButtonOffer(
                  //   onPressed: () {
                  //     sqlPorakiCartService().insertItemCarrinho(new sqlCarrinho(
                  //         _product.ofertaID.toString(),
                  //         '', //ofertaGUID,
                  //         _product.ofertaTitulo.toString(),
                  //         _product.ofertaCEP.toString(),
                  //         '', //ofertaVendedorGUID,
                  //         _product.ofertaPreco.toString(),
                  //         '1', //ofertaQtd,
                  //         _product.ofertaImgPath.toString(),
                  //         _product.categoriaChave.toString(),
                  //         DateTime.now().add(new Duration(hours: 1)).toString() // adiciona 1h
                  //     ));
                  //
                  //     Get.toNamed(
                  //       AppRoutes.shoppingCart,
                  //     );
                  //   },
                  //   colorText: AppColors.primaryColor,
                  //   text: 'Adicionar ao carrinho',
                  //   colorButton: AppColors.grayBlueButton,
                  // ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
