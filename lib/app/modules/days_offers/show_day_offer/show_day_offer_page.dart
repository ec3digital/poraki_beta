import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/app_bar_show_day_offer.dart';
import 'widgets/body_show_day_offer.dart';
import '../../home/widgets/drawer_home.dart';


class ShowDayOfferPage extends StatelessWidget {
  const ShowDayOfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ShowDayOfferController _controller = new ShowDayOfferController();
    // _controller.offerId = 2;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.12),
        child: AppBarShowDayOffer(
          adressUser: 'Enviar para Caique Marconi - Rua Castelo Velho 118',
        ),
      ),
      drawer: DrawerHome(-1),
      body: SingleChildScrollView(child: BodyShowDayOffer()),
    );
  }
}
