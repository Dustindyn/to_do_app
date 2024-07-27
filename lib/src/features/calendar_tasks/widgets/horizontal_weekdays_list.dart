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
    return date.day > 6 ? (date.day + 6) * 48.0 : 0.0;
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
        //TODO: the scrolling doesn't really work because the callback triggers this to rebuild
        setState(() {
          _scrollController.jumpTo(_getSelectedDateScrollOffset(value));
        });
      }
    });
  }
}
