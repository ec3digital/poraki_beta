import 'package:get/get.dart';

import '../modules/auth/login/login_page.dart';
import '../modules/auth/sign_up/sign_up_page.dart';
import '../modules/days_offers/days_offers_page.dart';
import '../modules/days_offers/show_day_offer/show_day_offer_page.dart';
import '../modules/days_offers/show_day_offer/widgets/view_search_product.dart';
import '../modules/home/home_page.dart';
import '../modules/shopping_cart/shopping_cart_page.dart';
import '../modules/testes_widgets/testeofer/telaofer.dart';
import 'app_routes.dart';

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
      page: () => TelaOfer(),
    ),
    GetPage(
      name: AppRoutes.shoppingCart,
      page: () => ShoppingCartPage(),
    ),
  ];
}
