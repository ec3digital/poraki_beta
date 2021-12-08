import 'package:flutter/material.dart';
import 'package:poraki/app/modules/offers/widgets/app_offers.dart';
import 'package:poraki/app/modules/offers/widgets/body_offer.dart';

class OfferPage extends StatelessWidget {
  final int offerId;
  OfferPage({Key? key, required this.offerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: appBarOffers(),
      body: SingleChildScrollView(child: BodyOffer(offerId: args)),
    );
  }
}
