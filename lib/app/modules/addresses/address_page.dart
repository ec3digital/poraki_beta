import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/addresses/widgets/app_bar_address.dart';
import 'package:poraki/app/modules/addresses/widgets/body_address.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';

class AddressPage extends StatelessWidget {
  final String? enderecoGuid;
  AddressPage({Key? key, this.enderecoGuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return Scaffold(
      //appBar: appBarAddress(),
      // appBar: PreferredSize(
      //   preferredSize: Size(double.maxFinite, 55),
      //   child: AppBarHome(controller: controller),
      // ),
      body: AddressBody(),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),

    );
  }
}