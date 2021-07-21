import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'days_offers_controller.dart';
import 'days_offers_widgets/app_days_offers.dart';
import 'days_offers_widgets/body_days_offers.dart';

class DaysOffersPage extends StatelessWidget {
  final DaysOffersController _controller = Get.put(DaysOffersController());

  DaysOffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDayOffers(),
      body: BodyDaysOffers(controller: _controller),
    );
  }
}
