import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poraki/app/modules/auth/login/login_page.dart';
import 'package:poraki/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'PorAki',
    //   home: LoginPage(),
    //   debugShowCheckedModeBanner: false,
    //   // localizationsDelegates: [
    //   //   GlobalMaterialLocalizations.delegate,
    //   //   GlobalWidgetsLocalizations.delegate
    //   // ],
    //   // supportedLocales: [const Locale('pt', 'BR')],
    // );

    return GetMaterialApp(
      title: 'PorAki',
      getPages: AppPages.routes,
      // onGenerateRoute: AppPages.routes,
      // theme: AppTheme.light(),4
      // themeMode: ThemeMode.light,
      home: LoginPage(),
      // initialRoute: AppRoutes.login,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: Duration(seconds: 0),
      // initialBinding: InitialBindings(),
      debugShowMaterialGrid: false,
      navigatorKey: Get.key, // chave,
      defaultGlobalState: true,
      //routes: AppPages.routes,
      // key: ,
      // debugShowCheckedModeBanner: false,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate
      // ],
      // supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
