import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/features/calendar_tasks/widgets/month_picker.dart';
import 'package:you_do/src/features/calendar_tasks/widgets/weekday_box.dart';

class HorizontalWeekdaysList extends StatefulWidget {
  const HorizontalWeekdaysList({super.key});

  @override
  State<HorizontalWeekdaysList> createState() => _HorizontalWeekdaysListState();
}

class _HorizontalWeekdaysListState extends State<HorizontalWeekdaysList> {
  late ScrollController _scrollController;
  late int days;
  late DateTime _selectedDate;

  double get _selectedDateScrollOffset {
    return _selectedDate.day > 6 ? (_selectedDate.day + 6) * 48.0 : 0.0;
  }

  @override
  initState() {
    _selectedDate = DateTime.now();
    _scrollController =
        ScrollController(initialScrollOffset: _selectedDateScrollOffset);
    days = _selectedDate.daysInMonth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final days = _selectedDate.daysInMonth;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MonthPicker(_selectedDate, onPressed: _onMonthPicked),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            width: 500,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                itemCount: days,
                itemBuilder: (context, index) {
                  final date = DateTime(
                      _selectedDate.year, _selectedDate.month, index + 1);
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 16,
                    ),
                    child: GestureDetector(
                        onTap: () => setState(() {
                              _selectedDate = date;
                            }),
                        child: WeekdayBox(date,
                            isSelected: date.isSameDate(_selectedDate))),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _onMonthPicked() {
    showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      unselectedMonthTextColor: Colors.white,
      selectedMonthTextColor: Colors.white,
      headerColor: context.theme.cardColor,
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
          _scrollController.jumpTo(_selectedDateScrollOffset);
        });
      }
    });
  }
}
