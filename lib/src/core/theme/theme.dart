import 'package:flutter/material.dart';

var theme = ThemeData(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: const Color(0xffef6c01),
    secondary: const Color(0xffef6c01),
    error: Colors.red,
  ),
  primaryColor: const Color(0xffef6c01),
  hintColor: const Color(0xffff7300),
  //cardColor: const Color(0xff23374a),
  scaffoldBackgroundColor: const Color(0xff22303c),
  dividerColor: Colors.grey[700],
  timePickerTheme: const TimePickerThemeData(
      backgroundColor: Color(0xff22303c),
      hourMinuteColor: Color(0xff2a3b4a),
      dialBackgroundColor: Color(0xff2a3b4a),
      dayPeriodColor: Color(0xffef6c01)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return const Color(0xff4a6572);
          }
          return const Color(0xffef6c01);
        },
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
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
