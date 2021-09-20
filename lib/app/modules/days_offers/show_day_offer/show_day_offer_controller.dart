import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'widgets/bottom_sheet_product_day_offer.dart';

class ShowDayOfferController extends GetxController {
  final TextEditingController amountController = TextEditingController();

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }

  int amountProduct = 1;
  bool changeBottomSheet = false;


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

  List<String> listPictures = [
    "https://cdn.pixabay.com/photo/2013/07/13/12/46/iphone-160307_960_720.png",
    "https://cdn.pixabay.com/photo/2013/07/13/12/46/iphone-160307_960_720.png",
    "https://cdn.pixabay.com/photo/2013/07/13/12/46/iphone-160307_960_720.png",
  ];
}
