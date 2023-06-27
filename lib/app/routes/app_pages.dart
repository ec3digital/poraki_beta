import 'package:get/get.dart';
import 'package:poraki/app/modules/account/account_bye_page.dart';
import 'package:poraki/app/modules/account/account_cancel_page.dart';
import 'package:poraki/app/modules/account/account_page.dart';
import 'package:poraki/app/modules/account/account_validation.dart';
import 'package:poraki/app/modules/addresses/address_page.dart';
import 'package:poraki/app/modules/addresses/addresses_list_page.dart';
import 'package:poraki/app/modules/auth/pw/forgot_pw_page.dart';
import 'package:poraki/app/modules/auth/pw/update_pw_page.dart';
import 'package:poraki/app/modules/auth/termos_page.dart';
import 'package:poraki/app/modules/categories/categories_page.dart';
import 'package:poraki/app/modules/chats/chatList_page.dart';
import 'package:poraki/app/modules/checkout/checkout_page.dart';
import 'package:poraki/app/modules/moffers/moffer_page.dart';
import 'package:poraki/app/modules/moffers/moffers_page.dart';
import 'package:poraki/app/modules/news/news_page.dart';
import 'package:poraki/app/modules/offers/offer_page.dart';
import 'package:poraki/app/modules/orders/order_page.dart';
import 'package:poraki/app/modules/orders/orders_page.dart';
import 'package:poraki/app/modules/stores/store_page.dart';
import 'package:poraki/app/modules/stores/stores_list_page.dart';
import 'package:poraki/app/poraki-splash.dart';
import '../modules/auth/login/login_page.dart';
import '../modules/auth/sign_up/sign_up_page.dart';
import '../modules/chats/chat_page.dart';
import '../modules/days_offers/days_offers_page.dart';
import '../modules/days_offers/show_day_offer/show_day_offer_page.dart';
import '../modules/days_offers/show_day_offer/widgets/view_search_product.dart';
import '../modules/home/home_page.dart';
import '../modules/locals/local_pick_page.dart';
import '../modules/shopping_cart/shopping_cart_page.dart';
import '../modules/stores/store_validation.dart';
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
        produtoOferta: null,
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
      page: () => AddressPage(enderecoGuid: ''),
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
      page: () => OrderPage(
        ped: null,
      ),
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
    ),
    GetPage(
      name: AppRoutes.porakiSplash,
      page: () => PorakiSplash(),
    ),
    GetPage(
      name: AppRoutes.news,
      page: () => NewsPage(),
    ),
    GetPage(
      name: AppRoutes.chats,
      page: () => ChatListPage(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatPage(),
    ),
    GetPage(
      name: AppRoutes.accountValidation,
      page: () => AccountValidation(),
    ),
    GetPage(
      name: AppRoutes.storeValidation,
      page: () => StoreValidation(),
    ),
    GetPage(
      name: AppRoutes.termos,
      page: () => TermosPage(),
    ),
    GetPage(
      name: AppRoutes.locals,
      page: () => LocalPickPage(),
    ),
    GetPage(
      name: AppRoutes.updatePw,
      page: () => UpdatePwPage(),
    ),
    GetPage(
      name: AppRoutes.forgotPw,
      page: () => ForgotPwPage(),
    ),
    GetPage(
      name: AppRoutes.accountCancel,
      page: () => AccountCancelPage(),
    ),
    GetPage(
      name: AppRoutes.accountBye,
      page: () => AccountByePage(),
    ),
  ];
}
