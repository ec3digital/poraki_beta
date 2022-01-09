import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return GetBuilder<HomeController>(builder: (_controller) {
      if (!_controller.isLoading) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Card(
              elevation: 3,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widgetTitle,
                      style: Get.textTheme.headline1,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Center(
                      child: Image.network(
                        imgOffer,
                        height: 300,
                        //scale: 1.7,
                      ),
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
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          details,
                          style: Get.textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Cep da oferta: $cepOffer',
                          style: Get.textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
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
                            style: TextStyle(color: Colors.blue),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.blue,
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
