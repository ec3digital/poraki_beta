import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PorAki',
      getPages: AppPages.routes,
      theme: AppTheme.light(),
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.home,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration(seconds: 0),
    );
  }
}
