import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/features/weekly_tasks/widgets/weekday_box.dart';

class HorizontalWeekdaysList extends StatelessWidget {
  const HorizontalWeekdaysList({super.key});

  @override
  Widget build(BuildContext context) {
    final weekdays = getDaysInWeek();
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: weekdays.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16,
            ),
            child: WeekdayBox(weekdays[index]),
          );
        });
  }
}
