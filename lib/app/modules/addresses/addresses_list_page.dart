
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/addresses/widgets/list_addresses.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';

class AddressesListPage extends StatelessWidget {
  final HomeController controller = Get.find(); // Get.put(HomeController());
  AddressesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: ListAddresses(),
      drawer: DrawerHome(0),
    );
  }
}
