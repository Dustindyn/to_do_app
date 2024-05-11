import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:you_do/src/core/theme/theme.dart';

Widget goldenWidgetWrapper(Widget widget) {
  return MaterialApp(
    theme: theme,
    home: Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: widget,
    ),
  );
}

GoldenBuilder getGoldenColumnBuilder() {
  return GoldenBuilder.column(bgColor: const Color(0xff22303c));
}
