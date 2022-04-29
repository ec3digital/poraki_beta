import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:poraki/app/data/models/categorias.dart';
import 'package:poraki/app/data/repositories/categories_repository.dart';
import '../../data/models/produto_oferta.dart';
import '../../data/repositories/offer_repository.dart';

class DaysOffersController extends GetxController {
  OfferRepository offerRepository = OfferRepository();
  CategoriesRepository categoriesRepository = CategoriesRepository();
  List<ProdutoOferta> offers = [];
  // List<Categorias>? categorias;

  final TextEditingController searchProductController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() async {
    await getOffers(4);
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

  Future<void> getOffers(int limit) async {
    try {
      changeLoading(true);
      offers = await offerRepository.getOffersAll(limit);
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
