import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/home_widgets/card_banner_alone_home.dart';
import 'package:poraki/app/modules/home/home_widgets/card_offerts_day_home.dart';
import 'appbar_search_field_home.dart';
import 'gradient_header_home.dart';
import 'list_horizontal_banners_home.dart';
import 'list_horizontal_categories_home.dart';

class BodyHome extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GradientHeaderHome(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.04),
            AppBarSearchFieldHome(),
            ListHorizontalBannersHome(controller: _controller),
            const SizedBox(height: 5),
            ListHorizontalCategoriesHome(controller: _controller),
            CardBannerAloneHome(),
            GetBuilder<HomeController>(
              builder: (_) {
                if (!_controller.isLoading) {
                  return CardOffertsDayHome(
                    title: _controller.offerToday!.ofertaTitulo!,
                    price: _controller.offerToday!.ofertaPreco!.toString(),
                    details: _controller.offerToday!.ofertaDetalhe!,
                    cepOffer: _controller.offerToday!.ofertaCEP!,
                    imgOffer:
                        'https://cdn2.iconfinder.com/data/icons/black-friday-shopping-3/252/Asset_1140-256.png',
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
