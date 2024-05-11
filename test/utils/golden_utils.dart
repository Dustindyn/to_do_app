import 'package:flutter/material.dart';
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
