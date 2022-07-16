import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/orders/widgets/list_orders.dart';

class OrdersPage extends StatelessWidget {
  //String tipo = '';
  OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();
    HomeController controller = Get.find();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: ListOrders(),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
    );
  }
}