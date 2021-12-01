import 'package:flutter/material.dart';
import 'package:poraki/app/modules/offers/widgets/app_offers.dart';
import 'package:poraki/app/modules/offers/widgets/body_offers.dart';

class OffersPage extends StatelessWidget {
  OffersPage({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarOffers(),
      body: BodyOffers(),
    );
  }
}
