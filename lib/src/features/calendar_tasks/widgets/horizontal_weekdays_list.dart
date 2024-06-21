import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/features/calendar_tasks/widgets/weekday_box.dart';

class HorizontalWeekdaysList extends StatefulWidget {
  final void Function(DateTime date) onPressed;
  final DateTime selectedDate;
  const HorizontalWeekdaysList(this.selectedDate,
      {required this.onPressed, super.key});

  @override
  State<HorizontalWeekdaysList> createState() => _HorizontalWeekdaysListState();
}

class _HorizontalWeekdaysListState extends State<HorizontalWeekdaysList> {
  late ScrollController _scrollController;
  late int days;
  @override
  initState() {
    _scrollController = ScrollController();
    days = widget.selectedDate.daysInMonth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollToSelectedDate());
    final days = widget.selectedDate.daysInMonth;
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        itemCount: days,
        itemBuilder: (context, index) {
          final date = DateTime(
              widget.selectedDate.year, widget.selectedDate.month, index + 1);
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16,
            ),
            child: GestureDetector(
                onTap: () => widget.onPressed(date),
                child: WeekdayBox(date,
                    isSelected: date.isSameDate(widget.selectedDate))),
          );
        });
  }

  void _scrollToSelectedDate() {
    final offset = widget.selectedDate.day > 6
        ? (widget.selectedDate.day + 6) * 48.0
        : 0.0;
    _scrollController.animateTo(offset,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}
