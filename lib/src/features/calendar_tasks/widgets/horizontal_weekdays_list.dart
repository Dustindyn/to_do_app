import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/features/calendar_tasks/widgets/weekday_box.dart';

class HorizontalWeekdaysList extends StatelessWidget {
  final void Function(DateTime date) onPressed;
  final DateTime selectedDate;
  const HorizontalWeekdaysList(this.selectedDate,
      {required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    final days = selectedDate.daysInMonth;
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: days,
        itemBuilder: (context, index) {
          final date =
              DateTime(selectedDate.year, selectedDate.month, index + 1);
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16,
            ),
            child: GestureDetector(
                onTap: () => onPressed(date),
                child: WeekdayBox(date,
                    isSelected: date.isSameDate(selectedDate))),
          );
        });
  }
}
