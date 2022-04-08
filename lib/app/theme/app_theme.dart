import 'package:flutter/material.dart';

abstract class AppColors {
  static Color primaryColor = Color(Colors.brown.value); // Color(0xff0000FF);
  static Color secondaryColor = Color(Colors.deepOrangeAccent.value); //Color(0xff00F000);
  static Color primaryColorButton = Color(0xFF116530);
  static Color secondaryColorButton = Color(0xffb3c9f2);
  static Color containerLightColor = Color(0xffEEEEEE);
  static Color borderColor = Color(0xff9E9E9E);
  static Color darkText = Color(0x8a000000);
  static Color primaryDark = Color(0xff161616);
  static Color primaryLight = Color(0xffF7F7F7);
  static Color primaryBackground = Color(0xFFA3EBB1);
  static Color secondaryBackground = Color(0xFF21B6A8);
  //static Color primaryGradientColor = Color(0xfff9b11f);
  //static Color secondaryGradientColor = Color(0xff692107);
}

abstract class AppTheme {
  static ThemeData light() {
    return ThemeData(
      splashColor: AppColors.primaryBackground,
      primaryColor: AppColors.primaryColor,
       
      scaffoldBackgroundColor: AppColors.primaryLight,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.darkText),
        elevation: 0.0,
        centerTitle: true,
        color: Colors.transparent,
        // ignore: deprecated_member_use
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Colors.black,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryBackground),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.primaryDark,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        centerTitle: true,
        color: Colors.transparent,
        // ignore: deprecated_member_use
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.primaryColor,
      ),
    );
  }
}
