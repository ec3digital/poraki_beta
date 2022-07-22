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
    final Color darkText = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());

    // RichText richDispo(String disponibilidade) {
    //   return new RichText(text:
    //   TextSpan(children: <TextSpan>
    //       []
    //   )
    //   );
    // }


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

          var detail2 = '';
          var detailDispo = '';
          if(produtoOferta.segDas!.toString() != 'null')// && (produtoOferta.segDas!.toString() != '00:00' && produtoOferta.segAs!.toString() != '23:59'))
            detailDispo += 'Seg das ' + produtoOferta.segDas.toString() + ' às ' + produtoOferta.segAs.toString();

          if(produtoOferta.terDas!.toString() != 'null')// && (produtoOferta.terDas!.toString() != '00:00' && produtoOferta.terAs!.toString() != '23:59'))
            detailDispo += ' / Ter das ' + produtoOferta.terDas.toString() + ' às ' + produtoOferta.terAs.toString();

          if(produtoOferta.quaDas!.toString() != 'null')// && (produtoOferta.quaDas!.toString() != '00:00' && produtoOferta.quaAs!.toString() != '23:59'))
            detailDispo += ' / Qua das ' + produtoOferta.quaDas.toString() + ' às ' + produtoOferta.quaAs.toString();

          if(produtoOferta.quiDas!.toString() != 'null')// && (produtoOferta.quiDas!.toString() != '00:00' && produtoOferta.quiAs!.toString() != '23:59'))
            detailDispo += ' / Qui das ' + produtoOferta.quiDas.toString() + ' às ' + produtoOferta.quiAs.toString();

          if(produtoOferta.sexDas!.toString() != 'null')// && (produtoOferta.sexDas!.toString() != '00:00' && produtoOferta.sexAs!.toString() != '23:59'))
            detailDispo += ' / Sex das ' + produtoOferta.sexDas.toString() + ' às ' + produtoOferta.sexAs.toString();

          if(produtoOferta.sabDas!.toString() != 'null')// && (produtoOferta.sabDas!.toString() != '00:00' && produtoOferta.sabAs!.toString() != '23:59'))
            detailDispo += ' / Sáb das ' + produtoOferta.sabDas.toString() + ' às ' + produtoOferta.sabAs.toString();

          if(produtoOferta.domDas!.toString() != 'null')// && (produtoOferta.domDas!.toString() != '00:00' && produtoOferta.domAs!.toString() != '23:59'))
            detailDispo += ' / Dom das ' + produtoOferta.domDas.toString() + ' às ' + produtoOferta.domAs.toString();

          if(detailDispo == '')
            detailDispo = 'Todos os dias';

          if (produtoOferta.ofertaMarcaRevenda!.isNotEmpty)
            detail2 += produtoOferta.ofertaMarcaRevenda.toString();

          if (produtoOferta.ofertaEntregasAPartirDe!.isNotEmpty)
            detail2 += detail2.isNotEmpty
                ? ' / '
                : '' +
                    ' Entregas à partir de ' +
                    produtoOferta.ofertaEntregasAPartirDe.toString();

          if (produtoOferta.ofertaDispoAte!.isNotEmpty)
            detail2 += detail2.isNotEmpty
                ? ' - '
                : '' + ' Só até ' + produtoOferta.ofertaDispoAte.toString();

          // if(produtoOferta.!.isNotEmpty)
          //   detail2 = produtoOferta.ofertaMarcaRevenda.toString();
          //
          // if(produtoOferta.ofertaMarcaRevenda!.isNotEmpty)
          //   detail2 = produtoOferta.ofertaMarcaRevenda.toString();

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
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: darkText),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListPicsOffer(imagesList: offersImages),
                  // const SizedBox(height: 2),
                  Center(
                    child: Text(
                      'R\$ ${produtoOferta.ofertaPreco?.toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',') ?? ''}',
                      style: TextStyle(
                          fontSize: 25,
                          color: _loginController.colorFromHex(_loginController
                              .listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'backDark')
                              .first
                              .coreValor
                              .toString())),
                    ),
                  ),

                  const SizedBox(height: 5),
                  ButtonOffer(
                    onPressed: () async {
                      var entregaPrev =
                          DateTime.now().add(new Duration(hours: 1)).toString();
                      print('botao press, offerGuid: ' +
                          produtoOferta.ofertaGUID.toString());
                      var cart = new sqlCarrinho(
                          produtoOferta.ofertaID.toString(),
                          produtoOferta.ofertaGUID.toString(),
                          produtoOferta.ofertaTitulo.toString(),
                          produtoOferta.ofertaCEP.toString(),
                          produtoOferta.ofertaFKID.toString(),
                          produtoOferta.ofertaPreco.toString(),
                          '1',
                          produtoOferta.ofertaImgPath.toString(),
                          produtoOferta.categoriaChave.toString(),
                          entregaPrev,
                          produtoOferta.lojaID,
                          produtoOferta.ofertaDetalhe);

                      var msg =
                          await sqlPorakiCartService().insertItemCarrinho(cart);
                      showDialog<String>(
                          context: buildContext,
                          builder: (buildContext) => AlertDialog(
                                title: const Text("Aviso"),
                                content: Text(msg.removeAllWhitespace),
                              ));

                      Get.toNamed(
                        AppRoutes.shoppingCart,
                      );
                    },
                    // colorText: darkText,
                    text: 'Adicionar ao carrinho',

                    colorText: _loginController.colorFromHex(_loginController
                        .listCore
                        .where((coreItem) => coreItem.coreChave == 'textLight')
                        .first
                        .coreValor
                        .toString()),
                    colorButton: _loginController.colorFromHex(_loginController
                        .listCore
                        .where((coreItem) => coreItem.coreChave == 'iconColor')
                        .first
                        .coreValor
                        .toString()),
                  ),
                  const SizedBox(height: 5),
                  DetailOffer(
                    detailProduct: "Disponibilidade: ",
                    moreDetailProduct: detailDispo,
                  ),
                  const SizedBox(height: 10),
                  if (produtoOferta.ofertaPeso.toString() != '0')
                    Text('Peso: ' +
                        produtoOferta.ofertaPeso.toString() +
                        ' ' +
                        produtoOferta.ofertaPesoUnidade.toString()),
                  const SizedBox(height: 2),
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      if (produtoOferta.ofertaDetalhe != null)
                        Container(
                            width: Get.width,
                            color: _loginController.colorFromHex(
                                _loginController.listCore
                                    .where((coreItem) =>
                                        coreItem.coreChave == 'backLight')
                                    .first
                                    .coreValor
                                    .toString()),
                            child: Column(mainAxisSize: MainAxisSize.max,verticalDirection: VerticalDirection.up,
                                children: [
                                  const SizedBox(height: 5),
                              Text(
                                produtoOferta.ofertaDetalhe.toString(),
                                style: TextStyle(fontSize: 18),
                              ),
                              const SizedBox(height: 5)
                            ])),
                      if (produtoOferta.ofertaSinal != null)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            Text('Sinal de ' +
                                produtoOferta.ofertaSinal.toString() +
                                ' ' +
                                produtoOferta.ofertaSinalTipo.toString()),
                            const Divider(),
                          ],
                        ),
                      if (produtoOferta.ofertaTempoEntrega.toString() != '0')
                        Column(children: [
                          const SizedBox(height: 10),
                          Text('Tempo de Entrega: ' +
                              produtoOferta.ofertaTempoEntrega.toString() +
                              ' ' +
                              produtoOferta.ofertaTempoEntregaUnidade
                                  .toString()),
                          const Divider(),
                        ]),
                      if (produtoOferta.ofertaCores!.toString() != 'null')
                        Column(children: [
                          const SizedBox(height: 10),
                          Text(
                              'Cores: ' + produtoOferta.ofertaCores.toString()),
                          const Divider(),
                        ]),
                      if (produtoOferta.ofertaTamanhos.toString() != 'null')
                        Column(children: [
                          const SizedBox(height: 10),
                          Text('Tamanhos: ' +
                              produtoOferta.ofertaTamanhos.toString()),
                          const Divider(),
                        ]),
                    ],
                  )),
                  // SizedBox(height: 10),

                  // Text(
                  //   'Quantidade: 1',
                  //   style: TextStyle(color: darkText),
                  // ),
                  // const SizedBox(height: 10),
                  // Expanded(
                  //   detailProduct: detail2,
                  // ),

                  // ButtonOffer(
                  //   onPressed: () async {
                  //     var entregaPrev = DateTime.now().add(new Duration(hours: 1)).toString();
                  //     var cart = new sqlCarrinho(produtoOferta.ofertaID.toString(), produtoOferta.ofertaGUID.toString(), produtoOferta.ofertaTitulo.toString(), produtoOferta.ofertaCEP.toString(), produtoOferta.ofertaFKID.toString(), produtoOferta.ofertaPreco.toString(), '1', produtoOferta.ofertaImgPath.toString(), produtoOferta.categoriaChave.toString(), entregaPrev, produtoOferta.lojaID, produtoOferta.ofertaDetalhe);
                  //
                  //     var msg = await sqlPorakiCartService().insertItemCarrinho(cart);
                  //     showDialog<String>(context: buildContext, builder: (buildContext) =>
                  //         AlertDialog(title: const Text("Aviso"), content: Text(msg.removeAllWhitespace),));
                  //
                  //     Get.toNamed(AppRoutes.shoppingCart);
                  //   },
                  //   colorText: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textLight').first.coreValor.toString()),
                  //   text: 'Comprar agora',
                  //   colorButton: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
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
