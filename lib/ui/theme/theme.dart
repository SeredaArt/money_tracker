import 'package:flutter/material.dart';

ThemeData _themeLight = ThemeData.light();

final deepOrange = Colors.deepPurpleAccent;
final black54 = Colors.black54;

ThemeData themeLight = _themeLight.copyWith(
    primaryColorDark: deepOrange,
    cardTheme: CardTheme(
      margin: EdgeInsets.all(10),
      color: deepOrange,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white60),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
    chipTheme: ChipThemeData(
      selectedColor: deepOrange,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white60),
        borderRadius: BorderRadius.circular(5.0),
      ),
    ),
    primaryColorLight: deepOrange,
    progressIndicatorTheme: ProgressIndicatorThemeData(color: black54),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: deepOrange,
        suffixIconColor: MaterialStateColor.resolveWith((states) =>
        states.contains(MaterialState.focused) ? deepOrange : black54),
        border: UnderlineInputBorder(borderSide: BorderSide(color: deepOrange)),
        errorStyle: TextStyle(color: deepOrange),
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelStyle: TextStyle(color: deepOrange),
        disabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: deepOrange)),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: deepOrange))),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
              side: BorderSide(color: Colors.deepPurpleAccent),
              borderRadius: BorderRadius.circular(10.0),
            )),
            textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.black)),
            backgroundColor: MaterialStatePropertyAll(deepOrange))),
    textTheme: _textLight(_themeLight.textTheme),
    appBarTheme: AppBarTheme(
        centerTitle: false,
        color: Colors.black54,
        iconTheme: IconThemeData(color: deepOrange),
        titleTextStyle: TextStyle(color: deepOrange, fontSize: 20)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: black54,
        selectedItemColor: deepOrange,
        selectedIconTheme: IconThemeData(color: deepOrange)));

TextTheme _textLight(TextTheme base) {
  return base.copyWith(
    headlineMedium: TextStyle(color: Colors.black38, fontSize: 22),
    titleMedium: TextStyle(fontSize: 10, color: Colors.black),
    labelLarge: TextStyle(fontSize: 10, color: Colors.black),
  );
}
