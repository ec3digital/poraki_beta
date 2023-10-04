import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
// import 'package:poraki/app/modules/categories/categories_controller.dart';
import 'package:poraki/app/modules/offers/offers_controller.dart';
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

  @override
  void initState() {
    // try { OffersController _offerCtrl = Get.find(); }
    // catch (execpetion) { Get.lazyPut(() => OffersController()); }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: Get.key,
      appBar: PreferredSize(
        preferredSize: Size(double.maxFinite, 55),
        child: AppBarHome(controller: controller),
      ),
      body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          // header: defaultHeader,
          onRefresh: () async {
            await controller.getOffers(4);
            await controller.getBestOffers(4);
            await controller.getMostFreshOffers(4);
            await controller.getBestSellersOffers(4);
            await _loginController.getListBannersFromFBCloud();
            await _loginController.getCategories();

            //await Future.delayed(Duration(seconds: 1));
            _refreshController.refreshCompleted();
          },
          child: BodyHome()),
      drawer: DrawerHome(0),
    );
  }
}
