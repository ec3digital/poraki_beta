import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/modules/offers/widgets/app_offers.dart';
import 'package:poraki/app/modules/offers/widgets/body_offer.dart';

class OfferPage extends StatelessWidget {
  final ProdutoOferta? produtoOferta;
  OfferPage({Key? key, this.produtoOferta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ProdutoOferta;

    return Scaffold(
      appBar: appBarOffers('Oferta'),
      body: SingleChildScrollView(child: BodyOffer(produtoOferta: args)),
    );
  }
}
