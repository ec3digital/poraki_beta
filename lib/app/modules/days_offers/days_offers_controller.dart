import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/ofertas.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';

class DaysOffersController extends GetxController {
  OfferRepository offerRepository = OfferRepository();
  List<Ofertas>? offers;

  TextEditingController searchProductController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() async {
    await getOffers();
    super.onInit();
  }

  final List<String> categories = [
    "Celulares",
    "Computadores",
    "Bicicletas",
    "Eletrodomésticos",
    "Produtos De Beleza",
  ];

  Future<void> getOffers() async {
    try {
      changeLoading(true);
      offers = await offerRepository.getOffersAll();
    } catch (e) {
      print('Erro no getOffers() controller ${e.toString()}');
    } finally {
      changeLoading(false);
    }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }
}
