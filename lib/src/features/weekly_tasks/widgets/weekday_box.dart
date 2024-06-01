import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class WeekdayBox extends StatelessWidget {
  final DateTime date;
  const WeekdayBox(this.date, {super.key});

  @override
  Widget build(BuildContext context) {
    return Ink(
        padding: const EdgeInsets.all(6.0),
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: context.theme.primaryColor,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Text(
                  DateFormat('E').format(date),
                  style: context.theme.textTheme.displayLarge!.copyWith(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.3
                      ..color = Colors.black,
                  ),
                ),
                Text(DateFormat('E').format(date),
                    style: context.theme.textTheme.displayLarge),
              ],
            ),
            Stack(
              children: [
                Text(
                  DateFormat('dd').format(date),
                  style: context.theme.textTheme.displayLarge!.copyWith(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1.3
                      ..color = Colors.black,
                  ),
                ),
                Text(DateFormat('dd').format(date),
                    style: context.theme.textTheme.displayLarge),
              ],
            ),
          ],
        ));
  }
}
