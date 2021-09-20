import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../days_offers_controller.dart';
import 'list_categories_days_offers.dart';
import 'list_products_day_offers.dart';

class BodyDaysOffers extends StatelessWidget {
  final DaysOffersController controller;
  const BodyDaysOffers({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ListCategoriesDaysOffers(controller: controller),
        const SizedBox(height: 20),
        ListProductsDayOffers(controller: controller),
      ],
    );
  }
}
