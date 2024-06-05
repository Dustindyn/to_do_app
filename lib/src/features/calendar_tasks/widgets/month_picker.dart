import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class MonthPicker extends StatelessWidget {
  final DateTime month;
  final void Function() onPressed;
  const MonthPicker(this.month, {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Ink(
        width: 150,
        padding: const EdgeInsets.only(left: 14.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("yMMMM").format(month),
                style: context.theme.textTheme.displayMedium),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
