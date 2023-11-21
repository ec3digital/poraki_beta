import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';
import 'package:poraki/app/modules/moffers/widgets/list_moffers.dart';
import '../auth/login/login_controller.dart';

class MoffersPage extends StatelessWidget {
  MoffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find(); // Get.put(HomeController());
    final LoginController _loginController = Get.find();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      backgroundColor: _loginController.colorFromHex(_loginController.backDark),
      body:  Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [ListMoffers()]),
      drawer: DrawerHome(0),
    );
  }
}