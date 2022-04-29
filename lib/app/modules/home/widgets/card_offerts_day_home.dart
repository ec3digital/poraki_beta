import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../home_controller.dart';
import 'package:intl/intl.dart';

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
    LoginController _loginController = Get.find();
    OffersController offersController = Get.put(OffersController());
    Color textDark = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString());
    Color textLight = _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString());

    return GetBuilder<HomeController>(builder: (_controller) {
      if (!_controller.isLoading) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Card(
              elevation: 8,
              color: Color(0xffFFFFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                        widgetTitle,
                        style: TextStyle(color: textDark, fontSize: 30) //Get.textTheme.headline1,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: InfiniteCarousel.builder(
                      itemCount: cardListOffers.length,
                      itemExtent: 320,
                      loop: true,
                      controller: InfiniteScrollController(),
                      onIndexChanged: (index) {},
                      itemBuilder: (context, itemIndex, realIndex) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {

                              Future.wait([offersController.getOfferById(cardListOffers[itemIndex].ofertaID!)]);
                              Get.toNamed(AppRoutes.offer, arguments:
                              cardListOffers[itemIndex].ofertaID);
                            },
                            child: Container(padding: const EdgeInsets.all(15.0),
                              child:

                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child:
                                   FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/pholder.png',
                                    image: _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpath').first.coreValor.toString() + cardListOffers[itemIndex].ofertaID.toString() + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpathsuffix').first.coreValor.toString(),
                                    imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
                                    height: 130,
                                  ),),
                              SizedBox(height: 10),
                              Text(cardListOffers[itemIndex].ofertaTitulo.toString(), style: TextStyle(fontSize: 22, color: textDark),),
                              SizedBox(height: 5),

                              Text(
                                'R\$ ${double.parse(cardListOffers[itemIndex].ofertaPreco.toString()).toStringAsFixed(2).replaceAll(',', '').replaceAll('.', ',')}',

                                style: Get.textTheme.headline1!.copyWith(
                                  color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
                                ),
                              ),
                              Text(
                                cardListOffers[itemIndex].ofertaDetalhe.toString(),
                                style: Get.textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: textDark,
                                ),
                              ),
                              // Text(
                              //   'Cep da oferta: ${cardListOffers[itemIndex].ofertaCEP.toString()}',
                              //   style: Get.textTheme.bodyText1!.copyWith(
                              //     fontWeight: FontWeight.w400,
                              //     color: textDark,
                              //   ),
                              // ),
                            ],
                          ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: textLight,
                                    width: 1,
                                  ),
                                //boxShadow: kElevationToShadow[1],
                                color: Colors.white

                                // image: DecorationImage(
                                //   image: NetworkImage(kDemoImages[itemIndex]),
                                //   fit: BoxFit.fill,
                                // ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Divider(),
                  InkWell(
                    onTap: () {

                      // carrega as listas necessarias ao clicar
                      if (this.nomeLista.isNotEmpty) {
                        if (this.nomeLista == 'dayoffers') Future.wait([offersController.getDayOffers(24)]);

                        if (this.nomeLista == 'bestoffers') Future.wait([offersController.getBestOffers(24)]);

                        if (this.nomeLista == 'freshoffers') Future.wait([offersController.getMostFreshOffers(24)]);

                        if (this.nomeLista == 'bestsellers') Future.wait([offersController.getBestSellerOffers(24)]);
                      }

                      Get.toNamed(AppRoutes.offers, arguments: [
                      {'listName': nomeLista}, {'limit': 24}, {'category': null }, {'title': null}, {'ofertaGuid': null}] );
                    }
                      ,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 05, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'VER MAIS',
                            style: TextStyle(color: textDark,),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
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