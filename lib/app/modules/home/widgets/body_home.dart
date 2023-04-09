//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
//import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/services/fbporaki_service.dart';
import '../home_controller.dart';
import 'card_banner_alone_home.dart';
import 'card_offerts_day_home.dart';
import 'gradient_header_home.dart';
import 'list_horizontal_banners_home.dart';
import 'list_horizontal_categories_home.dart';

class BodyHome extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());


  Future<String> pegaGamefication() async {
    return await fbPorakiService()
        .getValueFromFirebase("akigame", "consumidor", "politica");
  }

  @override
  Widget build(BuildContext context) {
    late String textoVizinho = '';
    // FirebaseStorage storage = new FirebaseStorage(
    //     storageBucket: 'gs://osszefogasaszanhuzokert.appspot.com/'
    // );
    // StorageReference imageLink = storage.ref().child('giftShopItems').child(documentSnapshot['imageName']);
    // final imageUrl = await imageLink.getDownloadUrl();
    // Image.network(imageUrl.toString());

    LoginController _loginController = Get.find();

    return FutureBuilder(
        future: pegaGamefication(),
        builder: (context, futuro) {
          textoVizinho = ''; // futuro.data.toString();
          print('textoVizinho: ' + textoVizinho);
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
                      child: Text(
                          'Mostrando ofertas próximas à ' +
                               _loginController.listaEnderecos
                                  .where((end) => end.EnderecoAtual)
                                  .first
                                  .EnderecoLogra
                                  .toString(),
                          style:
                          TextStyle(
                              fontSize: 14, fontStyle: FontStyle.italic))),
                  //const SizedBox(height: 5),
                  GetBuilder<HomeController>(
                    builder: (_) {
                      if (_controller.isLoading ||
                          _controller.offersToday!.length == 0) {
                        return Container();
                      } else {
                        return CardOffertsDayHome(
                          cardListOffers: _controller.offersToday!,
                          widgetTitle: _loginController.listCore
                              .where((coreItem) =>
                          coreItem.coreChave == 'textCard1')
                              .first
                              .coreValor
                              .toString(),
                          nomeLista: 'dayoffers',
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
                          widgetTitle: _loginController.listCore
                              .where((coreItem) =>
                          coreItem.coreChave == 'textCard2')
                              .first
                              .coreValor
                              .toString(),
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
                          widgetTitle: _loginController.listCore
                              .where((coreItem) =>
                          coreItem.coreChave == 'textCard3')
                              .first
                              .coreValor
                              .toString(),
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
                          widgetTitle: _loginController.listCore
                              .where((coreItem) =>
                          coreItem.coreChave == 'textCard4')
                              .first
                              .coreValor
                              .toString(),
                          cardListOffers: _controller.mostfresheroffers!,
                          nomeLista: 'freshoffers',
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Cloud: ' + _loginController.cloudId.toString(),
                    textAlign: TextAlign.right,
                  )
                  //  TODO: to add - achados e perdidos, melhores serviços
                ],
              ),
            ),
          );
        }
    );
  }
}
