import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/events/event_controller.dart';
import 'package:poraki/app/modules/events/event_list_page.dart';
import 'package:poraki/app/modules/home/home_controller.dart';
import 'package:poraki/app/modules/home/widgets/app_bar_home.dart';
import 'package:poraki/app/modules/home/widgets/drawer_home.dart';

class EventPage extends StatelessWidget {
  EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find();
    final LoginController _loginController = Get.find();

    // Future.delayed(Duration.zero, () async { _news.carregaNoticias(); });

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(double.maxFinite, 55),
          child: AppBarHome(controller: controller),
        ),
        drawer: DrawerHome(0),
        backgroundColor: _loginController.colorFromHex(_loginController.listCore
            .where((coreItem) => coreItem.coreChave == 'backDark')
            .first
            .coreValor
            .toString()),
        body: EventsListPage());
  }
}
