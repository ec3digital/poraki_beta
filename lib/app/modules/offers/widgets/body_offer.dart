import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlCarrinho.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/offers/widgets/detail_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_cart_service.dart';
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
    LoginController _loginController = Get.find();
    Color darkText = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString());

    return Container(
      child: GetBuilder<OffersController>(builder: (context) {
        if (offersController.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //offersController.getOfferById(4);
          ProdutoOferta _product = offersController.offers
              .where((p) => p.ofertaID == this.offerId)
              .first;
          print('body_offer - ' + offersController.offers.length.toString());
          List<String> offersImages = [];
          offersImages.add(
              'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
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
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: darkText),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListPicsOffer(imagesList: offersImages),
                  const SizedBox(height: 15),
                  DetailOffer(detailProduct: _product.ofertaDetalhe),
                  SizedBox(height: 10),
                  Text(
                    'R\$ ${_product.ofertaPreco?.toStringAsFixed(2) ?? ''}',
                    style: TextStyle(
                      fontSize: 25, color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString())
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Quantidade: 1', style: TextStyle(color: darkText),),
                  SizedBox(height: 10),
                  ButtonOffer(
                    onPressed: () {
                      sqlPorakiCartService().insertItemCarrinho(new sqlCarrinho(
                          _product.ofertaID.toString(),
                          '', //ofertaGUID,
                          _product.ofertaTitulo.toString(),
                          _product.ofertaCEP.toString(),
                          '', //ofertaVendedorGUID,
                          _product.ofertaPreco.toString(),
                          '1', //ofertaQtd,
                          _product.ofertaImgPath.toString(),
                          _product.categoriaChave.toString(),
                          DateTime.now().add(new Duration(hours: 1)).toString() // adiciona 1h
                      ));

                      Get.toNamed(AppRoutes.shoppingCart);
                    },
                    colorText: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                    text: 'Comprar agora',
                    colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
                  ),
                  ButtonOffer(
                    onPressed: () {
                      sqlPorakiCartService().insertItemCarrinho(new sqlCarrinho(
                          _product.ofertaID.toString(),
                          '', //ofertaGUID,
                          _product.ofertaTitulo.toString(),
                          _product.ofertaCEP.toString(),
                          '', //ofertaVendedorGUID,
                          _product.ofertaPreco.toString(),
                          '1', //ofertaQtd,
                          _product.ofertaImgPath.toString(),
                          _product.categoriaChave.toString(),
                          DateTime.now().add(new Duration(hours: 1)).toString() // adiciona 1h
                      ));

                      Get.toNamed(
                        AppRoutes.shoppingCart,
                      );
                    },
                    colorText: darkText,
                    text: 'Adicionar ao carrinho',
                    colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
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
