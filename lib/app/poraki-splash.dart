import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/categories/categories_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';
import 'modules/auth/login/login_controller.dart';
import 'services/fbporaki_service.dart';

class PorakiSplash extends StatefulWidget {
  @override
  _PorakiSplash createState() => _PorakiSplash();
}

class _PorakiSplash extends State<PorakiSplash> {
  @override
  void initState() {
    super.initState();
    final LoginController _loginController = Get.find();
    final CategoriesController _categoriesController = Get.put(CategoriesController());

    Timer(Duration(seconds: 0), () async {
      await _loginController.runCore();

      await Future.wait([
        _loginController.getCloudId(),
        _loginController.loadUserData(),
        _loginController.getCategories(),
        _loginController.loadStoresData(),
        _loginController.loadOffersFavsGuids(),
        _categoriesController.getAllCategoriesFb(),
        _categoriesController.getQtyCategs(),
        _categoriesController.getCategoriesNamesFb(),

        // _loginController.loadOffersFavs(),
        // _loginController.loadAddressData(),
        // _loginController.getListBannersFromFBCloud(),
        _loginController.getBrands(),
      ]);

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
              width: MediaQuery.of(context).size.width * 0.9,
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
