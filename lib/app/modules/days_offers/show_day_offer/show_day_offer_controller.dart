import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import 'widgets/bottom_sheet_product_day_offer.dart';

class ShowDayOfferController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  OfferRepository offerRepository = OfferRepository();

  ProdutoOferta? offerTapped;

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  int amountProduct = 1;
  bool changeBottomSheet = false;
  bool isLoading = false;

  @override
  void onInit() async {
    await getOfferTapped();
    super.onInit();
  }

  openBottomSheet() {
    Get.bottomSheet(
        BottomSheetProductDayOffer(
        Get.put(ShowDayOfferController()),
      ),
    );
    update();
  }

  void changeAmount(int incrementAmount) {
    amountProduct = incrementAmount;
    print(amountProduct);
    update();
    Get.back();
  }

  void bottomSheetSixMore() {
    changeBottomSheet = !changeBottomSheet;
    print(changeBottomSheet);
    update();
  }

  void multipleAmounts() {
    amountProduct = int.parse(amountController.text);
    update();
    Get.back();
  }

  Future<void> getOfferTapped() async {
    try {
      changeLoading(true);
      List<ProdutoOferta> ofertaById = await offerRepository.getOfferById(1);
      offerTapped = ofertaById.first;

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

  List<String> listPictures = [
    "https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F2.jpg?alt=media",
  ];
}
