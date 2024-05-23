import 'package:flutter/material.dart';

var theme = ThemeData(
  primaryColor: const Color(0xffef6c01),
  //cardColor: const Color(0xff23374a),
  scaffoldBackgroundColor: const Color(0xff22303c),
  cardColor: const Color(0xff2a3b4a),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      color: Colors.white,
    ),
  ).apply(),
);
