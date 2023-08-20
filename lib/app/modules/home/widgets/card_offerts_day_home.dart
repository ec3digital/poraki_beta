import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../home_controller.dart';
//import 'package:intl/intl.dart';

class CardOffertsDayHome extends StatelessWidget {
  final List<ProdutoOferta> cardListOffers;
  final String widgetTitle;
  final String nomeLista;

  const CardOffertsDayHome({
    Key? key,
    required this.cardListOffers,
    required this.widgetTitle,
    required this.nomeLista,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController _loginController = Get.find();
    final OffersController offersController = Get.put(OffersController());

    final Color textDark = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'textDark')
        .first
        .coreValor
        .toString());
    final Color textLight = _loginController.colorFromHex(_loginController
        .listCore
        .where((coreItem) => coreItem.coreChave == 'backLight')
        .first
        .coreValor
        .toString());

    return GetBuilder<HomeController>(builder: (_controller) {
      if (!_controller.isLoading) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Card(
              elevation: 10,
              //color: Color(0xffFFFFFF),
              color: _loginController.colorFromHex(_loginController.listCore
                  .where((coreItem) => coreItem.coreChave == 'backLight')
                  .first
                  .coreValor
                  .toString()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widgetTitle,
                        style: TextStyle(
                            color: textDark,
                            fontSize: 24) //Get.textTheme.headline1,
                        ),
                  ),
                  SizedBox(
                    height: 260,
                    child: InfiniteCarousel.builder(
                      itemCount: cardListOffers.length,
                      itemExtent: 260,
                      loop: true,
                      controller: InfiniteScrollController(),
                      onIndexChanged: (index) {},
                      itemBuilder: (context, itemIndex, realIndex) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              //Future.wait([offersController.getOfferById(cardListOffers[itemIndex].ofertaID!)]);
                              Get.toNamed(AppRoutes.offer,
                                  arguments: cardListOffers[itemIndex]);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: textDark,
                                      width: 1,
                                    )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // if(DateTime.parse(cardListOffers[itemIndex].ofertaDispoDesde) > )
                                    // Chip(
                                    //   //padding: EdgeInsets.all(0),
                                    //   backgroundColor: textDark,
                                    //   label: Text('TESTE', style: TextStyle(color: textLight)),
                                    // ),

                                    if (cardListOffers[itemIndex].oferta24hs !=
                                        null)
                                      if (cardListOffers[itemIndex].oferta24hs!)
                                        Chip(
                                          //padding: EdgeInsets.all(0),
                                          backgroundColor: textDark,
                                          label: Text('24hs',
                                              style:
                                                  TextStyle(color: textLight)),
                                        ),

                                    if (cardListOffers[itemIndex]
                                            .ofertaSomenteEncomenda !=
                                        null)
                                      if (cardListOffers[itemIndex]
                                          .ofertaSomenteEncomenda!)
                                        Chip(
                                          //padding: EdgeInsets.all(0),
                                          backgroundColor: textDark,
                                          label: Text('Somente encomenda',
                                              style:
                                                  TextStyle(color: textLight)),
                                        ),

                                    if (cardListOffers[itemIndex]
                                            .ofertaEntregasAPartirDe
                                            .toString() !=
                                        'null')
                                      if (DateTime.parse(
                                              cardListOffers[itemIndex]
                                                  .ofertaEntregasAPartirDe!)
                                          .isAfter(DateTime.now()))
                                        Chip(
                                          //padding: EdgeInsets.all(0),
                                          backgroundColor: textDark,
                                          label: Text('Entregas em breve !',
                                              style:
                                                  TextStyle(color: textLight)),
                                        ),

                                    if (cardListOffers[itemIndex]
                                            .ofertaAceitaEncomenda !=
                                        null)
                                      if (cardListOffers[itemIndex]
                                          .ofertaAceitaEncomenda!)
                                        Chip(
                                          //padding: EdgeInsets.all(0),
                                          backgroundColor: textDark,
                                          label: Text('Aceita encomenda',
                                              style:
                                                  TextStyle(color: textLight)),
                                        ),
                                    SizedBox(height: 5),
                                    Center(
                                        // child:
                                        //    FadeInImage.assetNetwork(
                                        //     placeholder: 'assets/images/pholder.png',
                                        //     image: _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpath').first.coreValor.toString() + cardListOffers[itemIndex].ofertaID.toString() + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpathsuffix').first.coreValor.toString(),
                                        //     imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
                                        //     height: 130,
                                        //   ),

                                        child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: CachedNetworkImage(
                                        imageUrl: _loginController.listCore
                                                .where((coreItem) =>
                                                    coreItem.coreChave ==
                                                    'imgpath')
                                                .first
                                                .coreValor
                                                .toString() +
                                            cardListOffers[itemIndex]
                                                .ofertaGUID
                                                .toString() +
                                            _loginController.listCore
                                                .where((coreItem) =>
                                                    coreItem.coreChave ==
                                                    'imgpathsuffix')
                                                .first
                                                .coreValor
                                                .toString(),
                                        progressIndicatorBuilder: (context, url,
                                                downloadProgress) =>
                                            CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.local_offer_outlined),
                                        height: 110,alignment: Alignment.bottomCenter,
                                      ),
                                    )),
                                    SizedBox(height: 10),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      verticalDirection: VerticalDirection.down,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            cardListOffers[itemIndex]
                                                .ofertaTitulo
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: textDark,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),

                                        SizedBox(height: 5),
                                        Text(
                                            'R\$ ${double.parse(cardListOffers[itemIndex].ofertaPreco.toString()).toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',')}',
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: _loginController
                                                  .colorFromHex(_loginController
                                                      .listCore
                                                      .where((coreItem) =>
                                                          coreItem.coreChave ==
                                                          'backDark')
                                                      .first
                                                      .coreValor
                                                      .toString()),
                                            ),
                                            textAlign: TextAlign.center),
                                        // Flexible(
                                        //   child: Text(
                                        //     cardListOffers[itemIndex]
                                        //         .ofertaDetalhe
                                        //         .toString(),
                                        //     style:
                                        //         Get.textTheme.bodyText1!.copyWith(
                                        //       fontWeight: FontWeight.w400,
                                        //       color: textDark,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    )),

                                    // Text(
                                    //   'Cep da oferta: ${cardListOffers[itemIndex].ofertaCEP.toString()}',
                                    //   style: Get.textTheme.bodyText1!.copyWith(
                                    //     fontWeight: FontWeight.w400,
                                    //     color: textDark,
                                    //   ),
                                    // ),
                                  ],
                                )),

                            //boxShadow: kElevationToShadow[1],
                            // color: _loginController.colorFromHex(
                            //     _loginController.listCore
                            //         .where((coreItem) =>
                            //             coreItem.coreChave == 'backLight')
                            //         .first
                            //         .coreValor
                            //         .toString()),

                            // image: DecorationImage(
                            //   image: NetworkImage(kDemoImages[itemIndex]),
                            //   fit: BoxFit.fill,
                            // ),
                          ),
                          // ),
                          //),
                        );
                      },
                    ),
                  ),

                  // const SizedBox(height: 5),
                  // Divider(),
                  InkWell(
                    onTap: () {
                      // carrega as listas necessarias ao clicar
                      var sendTitle = 'Ofertas';
                      if (this.nomeLista.isNotEmpty) {
                        if (this.nomeLista == 'dayoffers') {
                          sendTitle = 'Ofertas do dia';
                          Future.wait([offersController.getDayOffers(24)]);
                        }

                        if (this.nomeLista == 'bestoffers') {
                          sendTitle = 'Melhores ofertas';
                          Future.wait([offersController.getBestOffers(24)]);
                        }

                        if (this.nomeLista == 'freshoffers') {
                          sendTitle = 'Fresquinhas';
                          Future.wait(
                              [offersController.getMostFreshOffers(24)]);
                        }

                        if (this.nomeLista == 'bestsellers') {
                          sendTitle = "Mais vendidas";
                          Future.wait(
                              [offersController.getBestSellerOffers(24)]);
                        }
                      }

                      Get.toNamed(AppRoutes.offers, arguments: [
                        {'listName': nomeLista},
                        {'limit': 24},
                        {'category': null},
                        {'title': sendTitle},
                        {'ofertaGuid': null}
                      ]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 07, 07, 07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'VER MAIS',
                            style: TextStyle(
                              color: textDark,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: _loginController.colorFromHex(
                                _loginController.listCore
                                    .where((coreItem) =>
                                        coreItem.coreChave == 'iconColor')
                                    .first
                                    .coreValor
                                    .toString()),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
