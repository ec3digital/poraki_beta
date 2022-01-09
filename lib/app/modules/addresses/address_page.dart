import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/account/widgets/account_body.dart';
import 'package:poraki/app/modules/addresses/widgets/body_address.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';

class AddressPage extends StatelessWidget {
  final String? enderecoGuid;
  final HomeController controller = Get.find(); // Get.put(HomeController());
  AddressPage({Key? key, this.enderecoGuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: AddressBody(),
      drawer: DrawerHome(0),
    );
  }
}