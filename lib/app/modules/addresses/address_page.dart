import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/addresses/widgets/body_address.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';

class AddressPage extends StatelessWidget {
  String enderecoGuid = '';
  AddressPage({Key? key, required this.enderecoGuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    LoginController _loginController = Get.find();

    String _endGuid = '';
    try {
      var args = ModalRoute.of(context)?.settings.arguments
          as List<Map<String, String>>;
      _endGuid =
          args.first.values.first.toString(); //['enderecoGuid'].toString();

      // print('AddressPage _endGuid: ' + _endGuid);
    } catch (e) {}

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: AddressBody(
        enderecoGuid: _endGuid,
      ),
      drawer: DrawerHome(0),
      backgroundColor: _loginController.colorFromHex(_loginController.listCore
          .where((coreItem) => coreItem.coreChave == 'backDark')
          .first
          .coreValor
          .toString()),
    );
  }
}
