import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/app_offers.dart';
import 'widgets/list_offers.dart';

class OffersPage extends StatelessWidget {
  OffersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    String storeId = 'null';

    try {
      storeId = Get.arguments[5]['storeId'].toString();
    } catch (exception) {}

    print('storeId = ${storeId.toString()}');

    return Scaffold(
        appBar: appBarOffers(Get.arguments[3]['title']),
        body:
            // Padding(padding: const EdgeInsets.all(0)
            // Center(

            Container(
          decoration: new BoxDecoration(
              color: _loginController.colorFromHex(_loginController.listCore
                  .where((coreItem) => coreItem.coreChave == 'backDark')
                  .first
                  .coreValor
                  .toString())),
          // child: Expanded(
              // flex: 1,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  // gradient: new LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backLight').first.coreValor.toString()),
                  //     _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
                  //   ],
                  // )
                  // ),
                  // child:
                  // Column(mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [

                  //
                  // const SizedBox(height: 10),
                  // Text(
                  //   Get.arguments[3]['title'],
                  //   style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w500,
                  //       color: _loginController.colorFromHex(_loginController
                  //           .listCore
                  //           .where(
                  //               (coreItem) => coreItem.coreChave == 'textDark')
                  //           .first
                  //           .coreValor
                  //           .toString())),
                  // ),

                  const SizedBox(height: 10),
                  if (storeId.toString() != 'null')
                    CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/lojas%2F' +
                              storeId.toString() +
                              '.jpg?alt=media',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.local_offer_outlined),
                      height: 100,
                    ),
                  // const SizedBox(height: 2),

                  ListOffers()
                  // BodyOffers()
                ],
              )),
        // )
        // backgroundColor: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
        );
  }
}
