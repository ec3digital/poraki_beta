import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/lojas.dart';
import 'package:poraki/app/modules/addresses/widgets/body_address.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/stores/widgets/body_store.dart';

// ignore: must_be_immutable
class StorePage extends StatelessWidget {
  final Lojas? lojaObj;
  StorePage({Key? key, required this.lojaObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find(); // Get.put(HomeController());
    // final loja = ModalRoute.of(context)!.settings.arguments as Lojas?;
    // String _storeGuid = ModalRoute.of(context)!.settings.arguments.toString();

    //print('loja: ' + controller.loja.LojaNome.toString());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: StoreBody(),
      drawer: DrawerHome(0),
    );
  }
}