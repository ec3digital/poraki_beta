import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../home_controller.dart';
import 'card_banner_alone_home.dart';
import 'card_offerts_day_home.dart';
import 'gradient_header_home.dart';
import 'list_horizontal_banners_home.dart';
import 'list_horizontal_categories_home.dart';

class BodyHome extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // FirebaseStorage storage = new FirebaseStorage(
    //     storageBucket: 'gs://osszefogasaszanhuzokert.appspot.com/'
    // );
    // StorageReference imageLink = storage.ref().child('giftShopItems').child(documentSnapshot['imageName']);
    // final imageUrl = await imageLink.getDownloadUrl();
    // Image.network(imageUrl.toString());

    LoginController _loginController = Get.find();

    return SingleChildScrollView(
      child: GradientHeaderHome(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.02),
            ListHorizontalBannersHome(controller: _controller),
            const SizedBox(height: 5),
            ListHorizontalCategoriesHome(controller: _controller),
            CardBannerAloneHome(),
            const SizedBox(height: 10, ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
            Text('Mostrando ofertas próximas à ' + _loginController.listEnderecos.where((end) => end.EnderecoAtual).first.EnderecoLogra.toString())),
            // const SizedBox(height: 5),
            GetBuilder<HomeController>(
              builder: (_) {
                if (_controller.isLoading ||
                    _controller.offersToday!.length == 0) {
                  return Container();
                } else {
                  return CardOffertsDayHome(
                    cardListOffers: _controller.offersToday!,
                    widgetTitle: _loginController.listCore
                        .where((coreItem) => coreItem.coreChave == 'textCard1')
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
                        .where((coreItem) => coreItem.coreChave == 'textCard2')
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
                        .where((coreItem) => coreItem.coreChave == 'textCard3')
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
                        .where((coreItem) => coreItem.coreChave == 'textCard4')
                        .first
                        .coreValor
                        .toString(),
                    cardListOffers: _controller.mostfresheroffers!,
                    nomeLista: 'freshoffers',
                  );
                }
              },
            ),
          const SizedBox(height: 30,),
          Text('Cloud: ' + _loginController.cloudId.toString(), textAlign: TextAlign.right,)
          //  TODO: to add - achados e perdidos, melhores serviços

          ],
        ),
      ),
    );
  }
}
