import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/features/calendar_tasks/blocs/selected_date_cubit.dart';
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

  double _getSelectedDateScrollOffset(DateTime date) {
    // Calculate the index of the selected date (0-based)
    int selectedIndex = date.day - 1;

    // Calculate the offset, considering the width of each WeekdayBox (48 pixels)
    // and the horizontal padding (16 pixels on each side)
    double offset = selectedIndex * (34.5 + 32.0);

    // Adjust the offset to account for the padding at the start
    offset -= 16;

    // Ensure the offset is never negative
    return offset < 0 ? 0 : offset;
  }

  @override
  initState() {
    super.initState();
    final selectedDate = context.read<SelectedDateCubit>().state;
    _scrollController = ScrollController(
        initialScrollOffset: _getSelectedDateScrollOffset(selectedDate));
    days = selectedDate.daysInMonth;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedDateCubit, DateTime>(
      builder: (context, selectedDate) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
              _getSelectedDateScrollOffset(selectedDate),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        }
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MonthPicker(selectedDate,
                  onPressed: () => _onMonthPicked(selectedDate)),
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
                          selectedDate.year, selectedDate.month, index + 1);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 16,
                        ),
                        child: GestureDetector(
                            onTap: () => context
                                .read<SelectedDateCubit>()
                                .selectDate(date),
                            child: WeekdayBox(date,
                                isSelected: date.isSameDate(selectedDate))),
                      );
                    }),
              ),
            ],
          ),
        );
      },
    );
  }

  _onMonthPicked(DateTime selectedDate) {
    showMonthPicker(
      context: context,
      initialDate: selectedDate,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      unselectedMonthTextColor: Colors.white,
      selectedMonthTextColor: Colors.white,
      headerColor: context.theme.cardColor,
    ).then((value) {
      if (value != null) {
        context.read<SelectedDateCubit>().selectDate(value);
      }
    });
  }
}
