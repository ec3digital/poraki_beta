import 'package:get/get.dart';
import 'package:poraki/app/modules/account/account_page.dart';
import 'package:poraki/app/modules/addresses/address_page.dart';
import 'package:poraki/app/modules/addresses/addresses_list_page.dart';
import 'package:poraki/app/modules/categories/categories_page.dart';
import 'package:poraki/app/modules/checkout/checkout_page.dart';
import 'package:poraki/app/modules/moffers/moffer_page.dart';
import 'package:poraki/app/modules/moffers/moffers_page.dart';
import 'package:poraki/app/modules/offers/offer_page.dart';
import 'package:poraki/app/modules/orders/order_page.dart';
import 'package:poraki/app/modules/orders/orders_page.dart';
import 'package:poraki/app/modules/stores/store_page.dart';
import 'package:poraki/app/modules/stores/stores_list_page.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/sign_up/sign_up_page.dart';
import '../modules/days_offers/days_offers_page.dart';
import '../modules/days_offers/show_day_offer/show_day_offer_page.dart';
import '../modules/days_offers/show_day_offer/widgets/view_search_product.dart';
import '../modules/home/home_page.dart';
import '../modules/shopping_cart/shopping_cart_page.dart';
import 'app_routes.dart';
import '../modules/offers/offers_page.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.viewSearchProduct,
      page: () => ViewSearchProduct(),
    ),
    GetPage(
      name: AppRoutes.showDayOffer,
      page: () => ShowDayOfferPage(),
    ),
    GetPage(
      name: AppRoutes.daysOffers,
      page: () => DaysOffersPage(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: AppRoutes.offer,
      page: () => OfferPage(
        offerId: 0,
      ),
    ),
    GetPage(
      name: AppRoutes.shoppingCart,
      page: () => ShoppingCartPage(),
    ),
    GetPage(name: AppRoutes.offers, page: () => OffersPage()),
    GetPage(
      name: AppRoutes.categories,
      page: () => CategoriesPage(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => AccountPage(),
    ),
    GetPage(
      name: AppRoutes.addresses,
      page: () => AddressesListPage(),
    ),
    GetPage(
      name: AppRoutes.address,
      page: () => AddressPage(enderecoGuid: null),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckoutPage(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => OrdersPage(),
    ),
    GetPage(
      name: AppRoutes.order,
      page: () => OrderPage(sqlPed: null, ped: null),
    ),
    GetPage(
      name: AppRoutes.mOffers,
      page: () => MoffersPage(),
    ),
    GetPage(
      name: AppRoutes.mOffer,
      page: () => MOfferPage(offer: null),
    ),
    GetPage(
      name: AppRoutes.store,
      page: () => StorePage(lojaObj: null),
    ),
    GetPage(
      name: AppRoutes.stores,
      page: () => StoresListPage(),
    )
  ];
}
