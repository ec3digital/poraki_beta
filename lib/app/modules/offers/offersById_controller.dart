// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../data/models/produto_oferta.dart';
// import '../../data/repositories/offer_repository.dart';
//
// class OffersByIdController extends GetxController {
//   OfferRepository offerRepository = OfferRepository();
//   List<ProdutoOferta> offers = [];
//
//   final TextEditingController searchProductController = TextEditingController();
//   bool isLoading = false;
//
//   @override
//   void onInit() async {
//     await getOfferById(2);
//     super.onInit();
//   }
//
//   @override
//   void onClose() {
//     searchProductController.dispose();
//     super.onClose();
//   }
//
//   Future<void> getOfferById(int ofertaId) async {
//     try {
//       changeLoading(true);
//       offers = await offerRepository.getOfferById(ofertaId);
//     } catch (e) {
//       print('Erro no getOfferById() controller ${e.toString()}');
//     } finally {
//       changeLoading(false);
//     }
//   }
//
//   void changeLoading(bool newValue) {
//     isLoading = newValue;
//     update();
//   }
// }
