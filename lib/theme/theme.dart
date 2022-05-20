import 'package:flutter/material.dart';

/*
final defaultDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
  ),
);
*/
final defaultTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Lato',
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: const Color.fromRGBO(64, 151, 200, 1).withOpacity(.5),
    cursorColor: const Color.fromRGBO(64, 151, 200, 1).withOpacity(.6),
    selectionHandleColor: const Color.fromRGBO(64, 151, 200, 1).withOpacity(1),
  ),
  //textSelectionHandleColor: Colors.transparent,
  //accentColor: Color.fromRGBO(64, 151, 200, 1),
  indicatorColor: const Color.fromRGBO(64, 151, 200, 1),
  secondaryHeaderColor: const Color.fromRGBO(64, 151, 200, 1),
  primaryColor: const Color.fromRGBO(35, 35, 35, 1), // Colors.black,
  cardColor: Colors.black,
  dividerColor: const Color.fromRGBO(64, 151, 200, 1),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromRGBO(64, 151, 200, 1),
    foregroundColor: Colors.white,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color.fromRGBO(64, 151, 200, 1),
      fontSize: 25.0,
    ),
  ),
  //headline4 se usa en los nombres de las tarjetas de las instalaciones
  //headline5 se usa en los cards de datos de dispositivos en dispositivo_page
  //headline6 se usa en los titulos de los cards de datos de dispositivos en dispositivo_page
  textTheme: const TextTheme(
    headline4:
        TextStyle(fontSize: 35.0, color: Color.fromRGBO(64, 151, 200, 1)),
    headline5: TextStyle(
        fontSize: 16, color: Colors.white, decoration: TextDecoration.none),
    headline6: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(64, 151, 200, 1),
        decoration: TextDecoration.none),
  ),
  appBarTheme: const AppBarTheme(
    color: Color.fromRGBO(35, 35, 35, 1),
    centerTitle: true,
  ),
);
