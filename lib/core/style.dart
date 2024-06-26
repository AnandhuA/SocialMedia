import 'package:flutter/material.dart';
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
    fontSize: 37,
    fontWeight: FontWeight.w500,
    color: color,
  );
}

TextStyle headlineMediumStyle(Color color) {
  return TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
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

TextStyle titleMediumStyle(Color color) {
  return TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: color,
  );
}

TextStyle lableStyle(Color color) {
  return TextStyle(
    fontSize: 15,
    color: color,
  );
}

TextStyle linkTextStyle(Color color) {
  return TextStyle(
    color: color,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w500,
  );
}

//------------------InputDecorationStyle------------------

InputDecorationTheme inputDecorationStyle({
  required Color boderColor,
  required Color bacgroundColor,
}) {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.all(20),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: boderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: boderColor),
      borderRadius: BorderRadius.circular(20),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: errorColor),
    ),
    fillColor: bacgroundColor,
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: primaryColor),
    ),
    hintStyle: const TextStyle(
      color: lightModeLabelColor,
      fontSize: 15,
    ),
  );
}
