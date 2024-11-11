import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'home_controller.dart';
import 'widgets/app_bar_home.dart';
import 'widgets/body_home.dart';
import 'widgets/drawer_home.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final RefreshController _refreshController = RefreshController();
  final LoginController _loginController = Get.find();
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen(
      (status) {
        setState(() {
          _connectionStatus = status;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: Get.key,
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          const Text(
            'Conexão: ',
          ),
          Text(
            _connectionStatus?.toString() ?? '...',
          ),
          SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              // header: defaultHeader,
              onRefresh: () async {
                await controller.getOffers(4);
                await controller.getOffers2(4);
                await controller.getOffers3(4);
                await controller.getOffers4(4);
                await _loginController.getListBannersFromFBCloud();
                await _loginController.getCategories();
                await _loginController.getFBParams();

                //await Future.delayed(Duration(seconds: 1));
                _refreshController.refreshCompleted();
              },
              child: BodyHome())
        ],
      )),
      drawer: DrawerHome(0),
    );
  }
}
