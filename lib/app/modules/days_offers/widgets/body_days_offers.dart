import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:poraki/app/modules/home/widgets/gradient_header_home.dart';
import 'package:poraki/app/modules/offers/widgets/list_offers.dart';
import '../days_offers_controller.dart';

class BodyDaysOffers extends StatelessWidget {
  final DaysOffersController controller;
  const BodyDaysOffers({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GradientHeaderHome(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //ListCategoriesDaysOffers(controller: controller),
        const SizedBox(height: 20),
        //ListProductsDayOffers(),
        ListOffers(),
        // Text("teste"),
      ],
    )));
  }
}
