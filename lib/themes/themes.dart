import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color.fromARGB(255, 43, 160, 82),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.blueGrey,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.deepOrange),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 146, 43, 160),
  scaffoldBackgroundColor: const Color.fromARGB(255, 54, 50, 50),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
      elevation: MaterialStateProperty.all<double>(10.0),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(20.0),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
      elevation: MaterialStateProperty.all<double>(10.0),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(20.0),
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all<Color>(Colors.purple),
    trackColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
  ),
);
