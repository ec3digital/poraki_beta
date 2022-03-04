import 'package:flutter/material.dart';
import 'package:poraki/app/modules/account/account_page.dart';
import 'package:poraki/app/modules/auth/login/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poraki/app/modules/moffers/moffer_page.dart';
import 'package:poraki/app/modules/moffers/moffers_test.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PorAki',
      home: LoginPage(), //MoffersTest(), // MOfferPageTest(), // LoginPage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
