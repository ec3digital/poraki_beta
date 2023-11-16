//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'package:poraki/app/modules/offers/widgets/button_offer.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
//import 'package:poraki/app/routes/app_routes.dart';
// import 'package:poraki/app/services/fbporaki_service.dart';
import '../home_controller.dart';
import 'card_banner_alone_home.dart';
import 'card_offerts_day_home.dart';
import 'gradient_header_home.dart';
import 'list_horizontal_banners_home.dart';
import 'list_horizontal_categories_home.dart';

class BodyHome extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());
  final LoginController _loginController = Get.find();

  Future<String> pegaGamefication() async {
    return '';
    // return await fbPorakiService()
    //     .getValueFromFirebase("akigame", "consumidor", "politica");
  }

  // @override
  // void initState() async {}

  Future<void> loadAllOffers() async {
    print('passou no loadAllOffers');
    // try { OffersController _offerCtrl = Get.find(); }
    // catch (execpetion) { Get.lazyPut(() => OffersController()); }

    Get.lazyPut(() => OffersController());

    // Get.put(OffersController());

    await _controller.getMostFreshOffers(4);
    await _controller.getBestOffers(4);
    await _controller.getOffers(4);
    await _controller.getBestSellersOffers(4);

  }

  @override
  Widget build(BuildContext context) {
    // late String textoVizinho = '';
    // FirebaseStorage storage = new FirebaseStorage(
    //     storageBucket: 'gs://osszefogasaszanhuzokert.appspot.com/'
    // );
    // StorageReference imageLink = storage.ref().child('giftShopItems').child(documentSnapshot['imageName']);
    // final imageUrl = await imageLink.getDownloadUrl();
    // Image.network(imageUrl.toString());

    // loadAllOffers();

    // return FutureBuilder(
    //     future: pegaGamefication(),
    //     builder: (context, futuro) {
    //       textoVizinho = ''; // futuro.data.toString();
    //       print('textoVizinho: ' + textoVizinho);
    return FutureBuilder(
        future: loadAllOffers(),
        builder: (context, futuro) {
          if (futuro.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator(backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString())));
          } else {
            return SingleChildScrollView(
              child: GradientHeaderHome(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: Get.height * 0.01),
                    CardBannerAloneHome(),
                    const SizedBox(height: 10),
                    ListHorizontalBannersHome(controller: _controller),
                    const SizedBox(height: 5),
                    ListHorizontalCategoriesHome(controller: _controller),
                    // const SizedBox(height: 5),
                    // Container(
                    //     height: 40,
                    //     width: Get.width * 0.94,
                    //     decoration: BoxDecoration(
                    //       // border: Border.all(color: Colors.black),
                    //         color: Colors.cyan,
                    //         border: Border.all(
                    //           width: 1,
                    //         )),
                    //     //margin: EdgeInsets.all(10),
                    //     child: GestureDetector(
                    //         onTap: () {
                    //           Get.defaultDialog(
                    //             title: 'Voce pode ganhar prêmios no Poraki!',
                    //             middleText: textoVizinho.replaceAll('\\n', '\n')
                    //             //"Existem várias maneiras de ganhar prêmios no Poraki, através dos selos que voce conquista: \n\nSelo SUPER CONSUMIDOR\nvoce ganha este selo à partir de 20 compras realizadas através do aplicativo. \n\nSelo BOM VIZINHO\nvoce ganha este selo quando voce envia 10 avisos e que são validados por outro vizinho da sua região, ou quando você valida 20 avisos enviados por outros vizinhos. ",
                    //             //textConfirm: 'OK', onConfirm: () => Get.closeAllSnackbars()
                    //           );
                    //         },
                    //         child: Center(
                    //             child: Text(
                    //                 "Você pode ganhar prêmios no Poraki! \nClique para saber",
                    //                 textAlign: TextAlign.center,
                    //                 style: TextStyle(
                    //                     fontSize: 16,
                    //                     fontStyle: FontStyle.normal,
                    //                     fontWeight: FontWeight.normal))))),
                    const SizedBox(height: 5),
                    Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            // Text(
                            //     'Mostrando ofertas próximas à ' +
                            //         _loginController.listaEnderecos
                            //             .where((end) => end.EnderecoAtual)
                            //             .first
                            //             .EnderecoLogra
                            //             .toString(),
                            //     style: TextStyle(
                            //         fontSize: 14, fontStyle: FontStyle.italic)),
                            // const SizedBox(height: 5),
                            GestureDetector(
                              onTap: () => Get.toNamed(AppRoutes.locals),
                              child: Text(
                                "Clique aqui para mudar de região",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        )),
                    //const SizedBox(height: 5),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        if (_controller.isLoading ||
                            _controller.offersToday!.length == 0) {
                          return Container();
                        } else {
                          return CardOffertsDayHome(
                            cardListOffers: _controller.offersToday!,
                            widgetTitle: _loginController.textCard1,
                            nomeLista: 'offers1',
                          );
                        }
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        if (_controller.isLoading ||
                            _controller.bestoffers!.length == 0) {
                          return Container();
                        } else {
                          return CardOffertsDayHome(
                            widgetTitle: _loginController.textCard2,
                            cardListOffers: _controller.bestoffers!,
                            nomeLista: 'bestoffers',
                          );
                        }
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        if (_controller.isLoading ||
                            _controller.bestselleroffers!.length == 0) {
                          return Container();
                        } else {
                          return CardOffertsDayHome(
                            widgetTitle: _loginController.textCard3,
                            cardListOffers: _controller.bestselleroffers!,
                            nomeLista: 'bestsellers',
                          );
                        }
                      },
                    ),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        if (_controller.isLoading ||
                            _controller.mostfresheroffers!.length == 0) {
                          return Container();
                        } else {
                          return CardOffertsDayHome(
                            widgetTitle: _loginController.textCard4,
                            cardListOffers: _controller.mostfresheroffers!,
                            nomeLista: 'freshoffers',
                          );
                        }
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Quer ver as ofertas dos pequenos negócios que voce conhece no aplicativo ?",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    ButtonOffer(
                      text: 'Clique aqui para convidar',
                      colorText: Colors.white,
                      isWhatsapp: false,
                      colorButton: _loginController.colorFromHex(
                          _loginController.listCore
                              .where((coreItem) =>
                                  coreItem.coreChave == 'textDark')
                              .first
                              .coreValor
                              .toString()),
                      onPressed: () async {
                        var androidUrl =
                            "Oi, estou usando aplicativo de ofertas da região e acho que voce iria gostar de ver seus produtos ou serviços lá. Bora baixar ? ";
                        final link = WhatsAppUnilink(
                          // phoneNumber: '+5511997267192',
                          text: androidUrl,
                        );

                        await launchUrl(Uri.parse(link.asUri().toString()),
                            mode: LaunchMode.externalApplication);
                      },
                    ),

                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Cloud: ' + _loginController.cloudId.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.right,
                    )
                    //  TODO: to add - achados e perdidos, melhores serviços
                  ],
                ),
              ),
            );
            //});
          }
        });
  }
}
