import 'package:flutter/material.dart';

abstract class AppColors {
  static Color primaryColor = Color(0xff0000FF);
  static Color secondaryColor = Color(0xff00F000);
  static Color greenStrong = Color(0xff008E00);
  static Color purpleWeak = Color(0xffCCCCFF);
  static Color primaryDark = Color(0xff161616);
  static Color primaryLight = Color(0xffF7F7F7);
}

abstract class AppTheme {
  static ThemeData light() {
    return ThemeData(
      primaryColor: AppColors.primaryColor,
      accentColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.primaryLight,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        centerTitle: true,
        color: Colors.transparent,
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
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: Colors.white),
      primaryColor: AppColors.primaryColor,
      accentColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.primaryDark,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.0,
        centerTitle: true,
        color: Colors.transparent,
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
    );
  }
}
