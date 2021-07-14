import 'package:get/get.dart';
import 'package:poraki/app/modules/home/home_page.dart';
import 'package:poraki/app/modules/home_old/home_page.dart';
import 'package:poraki/app/modules/login/login_page.dart';
import 'package:poraki/app/modules/sign_up/sign_up_page.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.HOME_OLD,
      page: () => HomePageOld(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),
    GetPage(
      name: AppRoutes.HOME_OLD,
      page: () => HomePageOld(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpPage(),
    ),
  ];
}
