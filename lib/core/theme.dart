import 'package:flutter/material.dart';
import 'package:social_media/core/colors.dart';
import 'package:social_media/core/style.dart';

class ThemeClass {
  //
  //----------lightMode-----------

  static ThemeData lightTheme = ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        surface: surfaceLight,
        primary: primaryColor,
        secondary: secondaryColor,
        outline: lightModeBoder,
      ),
      elevatedButtonTheme: elevatedButtonStyle,
      textButtonTheme: textButtonStyle(color: blackColor),
      textTheme: TextTheme(
        headlineLarge: headlineStyle(blackColor),
        titleLarge: titleStyle(blackColor),
        titleMedium: titleMediumStyle(blackColor),
        labelLarge: lableStyle(lightModeLabelColor),
      ),
      inputDecorationTheme: inputDecorationStyle(
        boderColor: lightModeBoder,
        bacgroundColor: lightModeTextFeildBackground,
      ));

  //-----------darkMode-----------

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        surface: surfaceDark,
        primary: primaryColor,
        secondary: secondaryColor,
        outline: darkModeBoder,
      ),
      elevatedButtonTheme: elevatedButtonStyle,
      textButtonTheme: textButtonStyle(color: whiteColor),
      textTheme: TextTheme(
        headlineLarge: headlineStyle(whiteColor),
        titleLarge: titleStyle(whiteColor),
        titleMedium: titleMediumStyle(whiteColor),
        labelLarge: lableStyle(darkModeLabelColor),
      ),
      inputDecorationTheme: inputDecorationStyle(
        boderColor: darkModeBoder,
        bacgroundColor: darkModeTextFeildBackground,
      ));
}
