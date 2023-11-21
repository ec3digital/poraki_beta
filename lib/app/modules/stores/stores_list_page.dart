import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/stores/widgets/list_stores.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';

class StoresListPage extends StatelessWidget {
  final HomeController controller = Get.find(); // Get.put(HomeController());
  StoresListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: ListStores(),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.backDark),

    );
  }
}
