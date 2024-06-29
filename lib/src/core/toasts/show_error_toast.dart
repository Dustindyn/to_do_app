import 'package:flutter/material.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

void showErrorToast(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: context.theme.colorScheme.error,
      margin: const EdgeInsets.all(12),
      content: Row(children: [
        const Icon(Icons.error, color: Colors.white),
        const SizedBox(width: 12),
        Flexible(
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ]),
    ),
  );
}
