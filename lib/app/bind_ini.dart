import 'package:get/get.dart';
import 'package:poraki/app/modules/categories/categories_controller.dart';
import 'package:poraki/app/modules/moffers/brands_controller.dart';
import 'package:poraki/app/modules/moffers/partners_controller.dart';
import 'modules/addresses/address_controller.dart';
import 'modules/offers/offers_controller.dart';
import 'modules/offers/offersfav_controller.dart';
import 'modules/orders/order_controller.dart';
import 'modules/shopping_cart/shopping_cart_controller.dart';
import 'modules/stores/store_controller.dart';

class InitialBindings implements Bindings {
// default dependency
  @override
  void dependencies() {
    // Get.lazyPut(() => OrderController());
    Get.put(() => CategoriesController());
    Get.put(() => AddressController());
    //Get.lazyPut(() => OffersController());
    Get.put(() => StoreController());

    // Get.lazyPut(() => ShoppingCartController());

    //Get.lazyPut(() => BrandsController());

    // Get.lazyPut(() => PartnersController());
    //Get.put(() => OffersFavController());
    }
}