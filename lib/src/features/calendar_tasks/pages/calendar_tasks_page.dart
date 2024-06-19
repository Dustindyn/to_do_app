import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/features/calendar_tasks/widgets/month_picker.dart';
import 'package:you_do/src/features/dashboard/widgets/add_task_fab.dart';
import 'package:you_do/src/features/calendar_tasks/widgets/horizontal_weekdays_list.dart';

class CalendarTasksPage extends StatefulWidget {
  const CalendarTasksPage({super.key});

  @override
  State<CalendarTasksPage> createState() => _CalendarTasksPageState();
}

class _CalendarTasksPageState extends State<CalendarTasksPage> {
  DateTime _selectedMonth = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //TODO: use selected date as initial date for fab
    return Scaffold(
      floatingActionButton: AddTaskFab(
        initialDate: _selectedDate,
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MonthPicker(
                _selectedMonth,
                onPressed: _onMonthPickerPressed,
              ),
              const SizedBox(height: 8),
              SizedBox(
                  height: 88,
                  child: HorizontalWeekdaysList(
                    _selectedDate,
                    onPressed: _onDayPressed,
                  )),
              Divider(color: context.theme.dividerColor),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    //TODO: animated list here
                    for (final task in state.tasks
                        .where((t) => t.dueDate.isSameDate(_selectedDate)))
                      TaskBox(
                        task,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 64),
            ],
          );
        },
      ),
    );
  }

  void _onDayPressed(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  _onMonthPickerPressed() {
    showMonthPicker(
      context: context,
      initialDate: _selectedMonth,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      unselectedMonthTextColor: Colors.white,
      selectedMonthTextColor: Colors.white,
      headerColor: context.theme.cardColor,
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedMonth = value;
          _selectedDate = value;
        });
      }
    });
  }
}
