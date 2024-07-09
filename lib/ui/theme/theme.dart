import 'package:flutter/material.dart';

ThemeData _themeLight = ThemeData.light();

const deepOrange = Colors.deepPurpleAccent;
const black54 = Colors.black54;

ThemeData themeLight = _themeLight.copyWith(
    primaryColorDark: deepOrange,
    cardTheme: CardTheme(
      margin: const EdgeInsets.all(10),
      color: deepOrange,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white60),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    chipTheme: ChipThemeData(
      selectedColor: deepOrange,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white60),
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    primaryColorLight: deepOrange,
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: black54),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: deepOrange,
        suffixIconColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.focused) ? deepOrange : black54),
        border: const UnderlineInputBorder(borderSide: BorderSide(color: deepOrange)),
        errorStyle: const TextStyle(color: deepOrange),
        labelStyle: const TextStyle(color: Colors.black),
        floatingLabelStyle: const TextStyle(color: deepOrange),
        disabledBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: deepOrange)),
        focusedBorder:
        const UnderlineInputBorder(borderSide: BorderSide(color: deepOrange))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              side: const BorderSide(color: Colors.deepPurpleAccent),
              borderRadius: BorderRadius.circular(10.0),
            )),
            textStyle: const MaterialStatePropertyAll(TextStyle(color: Colors.black)),
            backgroundColor: const MaterialStatePropertyAll(deepOrange))),
    textTheme: _textLight(_themeLight.textTheme),
    appBarTheme: const AppBarTheme(
        centerTitle: false,
        color: Colors.black54,
        iconTheme: IconThemeData(color: deepOrange),
        titleTextStyle: TextStyle(color: deepOrange, fontSize: 20)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: black54,
        selectedItemColor: deepOrange,
        selectedIconTheme: IconThemeData(color: deepOrange)));

TextTheme _textLight(TextTheme base) {
  return base.copyWith(
    headlineMedium: const TextStyle(color: Colors.black38, fontSize: 22),
    titleMedium: const TextStyle(fontSize: 10, color: Colors.black),
    labelLarge: const TextStyle(fontSize: 10, color: Colors.black),
  );
}
