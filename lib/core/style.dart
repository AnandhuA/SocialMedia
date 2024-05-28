import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media/core/colors.dart';

//--------------ButtonStyle-----------------

ElevatedButtonThemeData elevatedButtonStyle = ElevatedButtonThemeData(
  style: ButtonStyle(
    minimumSize: const WidgetStatePropertyAll(
      Size(double.infinity, 60),
    ),
    backgroundColor: const WidgetStatePropertyAll(
      primaryColor,
    ),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
    ),
    foregroundColor: const WidgetStatePropertyAll(
      whiteColor,
    ),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
    ),
  ),
);

TextButtonThemeData textButtonStyle({required Color color}) {
  return TextButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(
        Size(double.infinity, 60),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
          side: BorderSide(
            color: color,
            width: 1,
          ),
        ),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
      ),
      foregroundColor: WidgetStatePropertyAll(
        color,
      ),
    ),
  );
}

//---------------TextStyle-----------------

TextStyle headlineStyle(Color color) {
  return TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: color,
  );
}

TextStyle titleStyle(Color color) {
  return TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle lableStyle(Color color) {
  return TextStyle(
    fontSize: 15,
    color: color,
  );
}

//------------------InputDecorationStyle------------------

InputDecorationTheme inputDecorationStyle(
    {required Color boderColor, required Color bacgroundColor}) {
  return InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(color: boderColor),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: boderColor),
        borderRadius: BorderRadius.circular(20)),
    fillColor: bacgroundColor,
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(20)),
    hintStyle: TextStyle(
      color: lightModeLabelColor,
    ),
    labelStyle: TextStyle(
      color: blackColor,
    ),
  );
}
