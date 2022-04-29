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

                    // title: _controller.offerToday!.ofertaTitulo ?? '',
                    // price: _controller.offerToday!.ofertaPreco.toString(),
                    // details: _controller.offerToday!.ofertaDetalhe ?? '',
                    // cepOffer: _controller.offerToday!.ofertaCEP ?? '',
                    // imgOffer:_loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpath').first.coreValor.toString() + _controller.offerToday!.ofertaID.toString() + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpathsuffix').first.coreValor.toString(),

                    //'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' + _controller.offerToday!.ofertaID.toString() + '.jpg?alt=media',
                    // 'https://cdn2.iconfinder.com/data/icons/black-friday-shopping-3/252/Asset_1140-256.png',
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

                    // title: _controller.bestoffer!.ofertaTitulo ?? '',
                    // price: _controller.bestoffer!.ofertaPreco.toString(),
                    // details: _controller.bestoffer!.ofertaDetalhe ?? '',
                    // cepOffer: _controller.bestoffer!.ofertaCEP ?? '',
                    // imgOffer: _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpath').first.coreValor.toString() + _controller.bestoffer!.ofertaID.toString() + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpathsuffix').first.coreValor.toString(),

                    nomeLista: 'bestoffers',
                    //'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' + _controller.bestoffer!.ofertaID.toString() + '.jpg?alt=media',
                    // 'https://cdn2.iconfinder.com/data/icons/black-friday-shopping-3/252/Asset_1140-256.png',
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

                    // title: _controller.bestselleroffer!.ofertaTitulo ?? '',
                    // price: _controller.bestselleroffer!.ofertaPreco.toString(),
                    // details: _controller.bestselleroffer!.ofertaDetalhe ?? '',
                    // cepOffer: _controller.bestselleroffer!.ofertaCEP ?? '',
                    // imgOffer: _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpath').first.coreValor.toString() + _controller.bestselleroffer!.ofertaID.toString() + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpathsuffix').first.coreValor.toString(),

                    nomeLista: 'bestsellers',
                    //'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' + _controller.bestselleroffer!.ofertaID.toString() + '.jpg?alt=media',
                    // 'https://cdn2.iconfinder.com/data/icons/black-friday-shopping-3/252/Asset_1140-256.png',
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

                    // title: _controller.bestselleroffer!.ofertaTitulo ?? '',
                    // price: _controller.bestselleroffer!.ofertaPreco.toString(),
                    // details: _controller.bestselleroffer!.ofertaDetalhe ?? '',
                    // cepOffer: _controller.bestselleroffer!.ofertaCEP ?? '',
                    // imgOffer:_loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpath').first.coreValor.toString() + _controller.bestselleroffer!.ofertaID.toString() + _loginController.listCore.where((coreItem) => coreItem.coreChave == 'imgpathsuffix').first.coreValor.toString(),

                    nomeLista: 'freshoffers',
                    //'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' + _controller.bestselleroffer!.ofertaID.toString() + '.jpg?alt=media',
                    // 'https://cdn2.iconfinder.com/data/icons/black-friday-shopping-3/252/Asset_1140-256.png',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
