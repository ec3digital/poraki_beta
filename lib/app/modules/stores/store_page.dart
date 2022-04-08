import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/modules/addresses/widgets/body_address.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/stores/widgets/body_store.dart';

class StorePage extends StatelessWidget {
  final Lojas? lojaObj;
  StorePage({Key? key, required this.lojaObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    LoginController _loginController = Get.find();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: StoreBody(),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),

    );
  }
}