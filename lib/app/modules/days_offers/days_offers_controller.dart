import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/produto_oferta.dart';
import '../../data/repositories/offer_repository.dart';

class DaysOffersController extends GetxController {
  OfferRepository offerRepository = OfferRepository();
  List<ProdutoOferta> offers = [];

  final TextEditingController searchProductController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() async {
    await getOffers();
    super.onInit();
  }

  @override
  void onClose() {
    searchProductController.dispose();
    super.onClose();
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
