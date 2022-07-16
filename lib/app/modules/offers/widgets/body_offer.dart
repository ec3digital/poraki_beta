import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/sql/sqlCarrinho.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/modules/offers/widgets/detail_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/services/sqlite/sqlporaki_cart_service.dart';
import '../../../data/models/produto_oferta.dart';
import '../offers_controller.dart';
import 'list_pics_offer.dart';

// ignore: must_be_immutable
class BodyOffer extends StatelessWidget {
  final ProdutoOferta produtoOferta;
  BodyOffer({Key? key, required this.produtoOferta}) : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    //OffersController offersController = Get.put(OffersController());
    final OffersController offersController = Get.find();
    final LoginController _loginController = Get.find();
    final Color darkText = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString());

    return Container(
      child: GetBuilder<OffersController>(builder: (context) {
        if (offersController.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {

          //ProdutoOferta _product = offersController.offers.where((p) => p.ofertaID == this.offerId).first;
          List<String> offersImages = [];
          offersImages.add(
              'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' +
                  produtoOferta.ofertaID.toString() +
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
                      produtoOferta.ofertaTitulo.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: darkText),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListPicsOffer(imagesList: offersImages),
                  const SizedBox(height: 15),
                  DetailOffer(detailProduct: produtoOferta.ofertaDetalhe),
                  SizedBox(height: 10),
                  Text(
                    'R\$ ${produtoOferta.ofertaPreco?.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',') ?? ''}',
                    style: TextStyle(
                      fontSize: 25, color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString())
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Quantidade: 1', style: TextStyle(color: darkText),),
                  SizedBox(height: 10),
                  ButtonOffer(
                    onPressed: () async {
                      var entregaPrev = DateTime.now().add(new Duration(hours: 1)).toString();
                      var cart = new sqlCarrinho(produtoOferta.ofertaID.toString(), produtoOferta.ofertaGUID.toString(), produtoOferta.ofertaTitulo.toString(), produtoOferta.ofertaCEP.toString(), produtoOferta.ofertaFKID.toString(), produtoOferta.ofertaPreco.toString(), '1', produtoOferta.ofertaImgPath.toString(), produtoOferta.categoriaChave.toString(), entregaPrev, produtoOferta.lojaID, produtoOferta.ofertaDetalhe);

                      var msg = await sqlPorakiCartService().insertItemCarrinho(cart);
                      showDialog<String>(context: buildContext, builder: (buildContext) =>
                          AlertDialog(title: const Text("Aviso"), content: Text(msg.removeAllWhitespace),));

                      Get.toNamed(AppRoutes.shoppingCart);
                    },
                    colorText: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                    text: 'Comprar agora',
                    colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
                  ),
                  ButtonOffer(
                    onPressed: () async {
                      var entregaPrev = DateTime.now().add(new Duration(hours: 1)).toString();
                      print('botao press, offerGuid: ' + produtoOferta.ofertaGUID.toString());
                      var cart = new sqlCarrinho(produtoOferta.ofertaID.toString(), produtoOferta.ofertaGUID.toString(), produtoOferta.ofertaTitulo.toString(), produtoOferta.ofertaCEP.toString(), produtoOferta.ofertaFKID.toString(), produtoOferta.ofertaPreco.toString(), '1', produtoOferta.ofertaImgPath.toString(), produtoOferta.categoriaChave.toString(), entregaPrev, produtoOferta.lojaID, produtoOferta.ofertaDetalhe);

                      var msg = await sqlPorakiCartService().insertItemCarrinho(cart);
                      showDialog<String>(context: buildContext, builder: (buildContext) =>
                          AlertDialog(title: const Text("Aviso"), content: Text(msg.removeAllWhitespace),));

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
