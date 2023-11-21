import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/account/widgets/account_body.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';

class AccountPage extends StatelessWidget {
  final HomeController controller = Get.find(); // Get.put(HomeController());
  AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: AccountBody(),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.backDark),

    );
  }
}