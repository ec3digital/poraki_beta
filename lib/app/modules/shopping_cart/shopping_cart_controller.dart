import 'package:get/get.dart';
import '../../data/models/shopping_cart_model.dart';
import 'widgets/dialog_amount_shopping_cart.dart';
import 'widgets/dialog_more_unitys_shopping_cart.dart';

class ShoppingCartController extends GetxController {
  int tabBarLenght = 0;
  bool change = false;

  String moreQuantity = '';

  changeMoreQuantity(String? value) {
    moreQuantity = value!;
    update();
  }

  List<ShoppingCartModel> listShoppingCart = [
    ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
    ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
    ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
    ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
    ShoppingCartModel('Xiaomi mi 11 Lite', 'assets/images/poraki_small.png', 1.528),
  ];

  showDialog() {
    Get.dialog(DialogAmountShoppingCart(Get.find()));
  }

  showDialogMoreUnitys() {
    Get.back();
    Get.dialog(DialogMoreUnitysShoppingCart(Get.find()));
  }

  cgsfgs() {}
}
