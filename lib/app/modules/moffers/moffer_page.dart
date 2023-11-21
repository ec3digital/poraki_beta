import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/moffers/widgets/body_moffer.dart';
import '../../data/models/oferta.dart';

class MOfferPage extends StatelessWidget {
  Oferta? offer;
  MOfferPage({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final LoginController _loginController = Get.find();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: BodyMoffer(
        offer: offer,
      ),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.backDark),
    );
  }
}
