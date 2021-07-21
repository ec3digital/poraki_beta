import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/routes/app_pages.dart';
import 'package:poraki/app/routes/app_routes.dart';
import 'package:poraki/app/theme/app_theme.dart';

import 'modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      title: 'PorAki',
      getPages: AppPages.routes,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.HOME,
      debugShowCheckedModeBanner: false,
    );
  }
}
