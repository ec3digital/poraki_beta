import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'modules/auth/login/login_controller.dart';

class PorakiSplash extends StatefulWidget {
  @override
  _PorakiSplash createState() => _PorakiSplash();
}

class _PorakiSplash extends State<PorakiSplash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () async {
      final LoginController _loginController = Get.put(LoginController());

      await _loginController.getCloudId();
      await _loginController.runCore();
      await _loginController.loadUserData();
      await _loginController.loadStoresData();
      await _loginController.loadAddressData();
      await _loginController.getListBannersFromFBCloud();
      Get.toNamed(AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        color: AppColors.secondaryBackground,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 40),
              Image.asset('assets/images/poraki250.png'),
              CircularProgressIndicator(),
              const SizedBox(height: 40),
              Text('procurando por ofertas próximas à voce... ;-)',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      color: AppColors.darkText)),
              const SizedBox(height: 180),
            ]));

  }
}
