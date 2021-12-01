import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                if (_controller.isLoading || _controller.offerToday == null) {
                  return Container();
                } else {
                  return CardOffertsDayHome(
                    title: _controller.offerToday!.ofertaTitulo ?? '',
                    price: _controller.offerToday!.ofertaPreco.toString(),
                    details: _controller.offerToday!.ofertaDetalhe ?? '',
                    cepOffer: _controller.offerToday!.ofertaCEP ?? '',
                    imgOffer:
                      'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F' + _controller.offerToday!.ofertaID.toString() + '.jpg?alt=media',
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
