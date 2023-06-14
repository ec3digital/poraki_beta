import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'modules/auth/login/login_controller.dart';
import 'services/fbporaki_service.dart';

class PorakiSplash extends StatefulWidget {
  @override
  _PorakiSplash createState() => _PorakiSplash();
}

class _PorakiSplash extends State<PorakiSplash> {
  //late String textSplash = '...';

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () async {
      //textSplash = await fbPorakiService().getValueFromFirebase("akisplash", "splash", "texto");
      //print('splash texto: ' + textSplash);
      final LoginController _loginController = Get.find(); //.put(LoginController());

      await _loginController.getCloudId();
      await _loginController.runCore();
      await _loginController.loadUserData();
      await _loginController.getCategories();
      await _loginController.loadStoresData();
      //await _loginController.loadOffersFavs();
      await _loginController.loadAddressData();
      await _loginController.getListBannersFromFBCloud();
      await _loginController.getBrands();
      Get.toNamed(AppRoutes.home);
    });
  }

  Future<String> pegaTextoSplash() async {
    return await fbPorakiService()
        .getValueFromFirebase("akisplash", "splash", "texto");
  }

  @override
  Widget build(BuildContext context) {
    String? textoSplash = '...';
    return FutureBuilder(
        future: pegaTextoSplash(),
    builder: (context, futuro) {
      textoSplash = (futuro.data ?? '...') as String?;
      return Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.9,
          color: AppColors.secondaryBackground,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                FadeInImage.assetNetwork(
                    placeholder: 'assets/images/poraki250.png',
                    image:
                    'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/App%2Fporaki-splash.png?alt=media'),
                CircularProgressIndicator(),
                const SizedBox(height: 40),
                Text(textoSplash.toString().replaceAll('\\n', '\n'),
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: AppColors.darkText)),
                const SizedBox(height: 180),
              ]));
    });
  }
}
