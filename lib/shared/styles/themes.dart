import 'package:cutpro/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class MyThemeData {
 

  static final ThemeData lightTheme = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryColor,
 
      appBarTheme: AppBarTheme(
        centerTitle: true,
          color: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: BlackColor)),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 30,
          color: BlackColor,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          fontSize: 25,
          color: BlackColor,
          fontWeight: FontWeight.w400,
        ),
        headline3: TextStyle(
          fontSize: 25,
          color: WhiteColor,
          fontWeight: FontWeight.w400,),
        subtitle1: TextStyle(
          fontSize: 25,
          color: BlackColor,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          fontSize: 20,
          color: BlackColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryColor,
          selectedItemColor: BlackColor, unselectedItemColor: Colors.white
      ),
      );

  static final ThemeData darkTheme = ThemeData(
      primaryColor: primaryColorDark,
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: WhiteColor)),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 30,
          color: WhiteColor,
          fontWeight: FontWeight.w700,
        ),
        headline2: TextStyle(
          fontSize: 25,
          color: YellowColor,
          fontWeight: FontWeight.w400,
        ),
        subtitle1: TextStyle(
          fontSize: 25,
          color: YellowColor,
          fontWeight: FontWeight.w500,
        ),
        bodyText1: TextStyle(
          fontSize: 20,
          color: YellowColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: YellowColor, unselectedItemColor: Colors.white));
}