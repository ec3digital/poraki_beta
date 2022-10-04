import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:poraki/app/modules/auth/login/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poraki/app/modules/chats/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PorAki',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate
      // ],
      // supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
