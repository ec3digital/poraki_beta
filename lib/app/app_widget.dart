import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_pages.dart';
import 'package:poraki/app/routes/app_routes.dart';

import 'modules/login/login_page.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PorAki',
      home: LoginPage(),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.HOME,
      debugShowCheckedModeBanner: false,
    );
  }
}
