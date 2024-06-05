import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class WeekdayBox extends StatelessWidget {
  final DateTime date;
  final bool isSelected;

  const WeekdayBox(this.date, {required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat("E").format(date),
            style: context.theme.textTheme.bodyMedium),
        const SizedBox(height: 8),
        Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? context.theme.primaryColor
                : context.theme.cardColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            DateFormat("dd").format(date),
            style: context.theme.textTheme.bodyLarge,
          ),
        )
      ],
    );
  }
}
