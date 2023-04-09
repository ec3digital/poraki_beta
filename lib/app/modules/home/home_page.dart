import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/categories/categories_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
import 'home_controller.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/body_home.dart';
import 'widgets/drawer_home.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  //final CategoriesController categController = Get.put(CategoriesController());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => OffersController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: BodyHome(),
      drawer: DrawerHome(0),
    );
  }
}
