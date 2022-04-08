import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_controller.dart';
import 'package:poraki/app/routes/app_routes.dart';
import '../home_controller.dart';

class CardOffertsDayHome extends StatelessWidget {
  final String title;
  final String price;
  final String details;
  final String cepOffer;
  final String imgOffer;
  final String widgetTitle;

  const CardOffertsDayHome({
    Key? key,
    required this.title,
    required this.price,
    required this.details,
    required this.cepOffer,
    required this.imgOffer,
    required this.widgetTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController _loginController = Get.find();

    return GetBuilder<HomeController>(builder: (_controller) {
      if (!_controller.isLoading) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Card(
              elevation: 8,
              color: Color(0xffFFFFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widgetTitle,
                      style: TextStyle(color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()), fontSize: 30) //Get.textTheme.headline1,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(

                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/pholder.png',
                        image: imgOffer,
                        imageErrorBuilder: (context, url, error) => new Icon(Icons.local_offer_outlined),
                        height: 300,
                      ),

                      // child: Image.network(
                      //   imgOffer,
                      //   height: 300,
                      //   //scale: 1.7,
                      // ),


                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        SizedBox(height: 5),
                        Text(
                          'R\$ $price',
                          style: Get.textTheme.headline1!.copyWith(
                            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'backDark').first.coreValor.toString()),
                          ),
                        ),
                        Text(
                          details,
                          style: Get.textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
                          ),
                        ),
                        Text(
                          'Cep da oferta: $cepOffer',
                          style: Get.textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(),
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.offers, arguments: [
                      {'cep': '05735030'}, {'category': null }, {'title': null}] ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 05, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ver todas',
                            style: TextStyle(color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'textDark').first.coreValor.toString()),),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: _loginController.colorFromHex(_loginController.listCore.where((coreItem) => coreItem.coreChave == 'iconColor').first.coreValor.toString()),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
