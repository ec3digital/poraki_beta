import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poraki/app/data/models/produto_oferta.dart';
import 'package:poraki/app/data/repositories/offer_repository.dart';
import 'widgets/bottom_sheet_product_day_offer.dart';

class ShowDayOfferController extends GetxController {
  final TextEditingController amountController = TextEditingController();
  OfferRepository offerRepository = OfferRepository();
  ProdutoOferta? offerTapped;
  int? offerId;

  ShowDayOfferController();

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
    changeLoading(true);
    print('onInit show_day_offer_controller');
    this.offerId = Get.arguments[0]['id'];
    if(offerId != null) {
      print('offerId: ' + this.offerId!.toString());
      //await getOfferTapped(offerId!.toInt());
      await getOfferTapped(this.offerId.toString());
    }

    print('Arguments: ${Get.arguments}');
    super.onInit();
    changeLoading(false);
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

  Future<void> getOfferTapped(String offerGuid) async {
    return null;
    // try {
    //   changeLoading(true);
    //   //if (this.offerId != null)
    //     //{
    //   //this.offerId = 2;
    //     this.offerId = Get.arguments[0]['id'];
    //     print('getOfferTapped id: ' + this.offerId.toString());
    //   offerTapped = (await offerRepository.getOfferByGuid(offerGuid)) as ProdutoOferta?;
    //     //offerTapped = ofertaByGuid.first;
    //    // /}
    //   //else
    //     //{
    //       //return null;
    //     //}
    //
    // } catch (e) {
    //   print('Erro no getOfferTapped() - controller ${e.toString()}');
    // } finally {
    //   changeLoading(false);
    // }
  }

  void changeLoading(bool newValue) {
    isLoading = newValue;
    update();
  }

  List<String> listPictures = [
    "https://firebasestorage.googleapis.com/v0/b/ec3digrepo.appspot.com/o/ofertas%2F2.jpg?alt=media",
  ];
}
