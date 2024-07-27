import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/features/calendar_tasks/blocs/selected_date_cubit.dart';
import 'package:you_do/src/features/dashboard/widgets/add_task_fab.dart';
import 'package:you_do/src/features/calendar_tasks/widgets/horizontal_weekdays_list.dart';

class CalendarTasksPage extends StatefulWidget {
  const CalendarTasksPage({super.key});

  @override
  State<CalendarTasksPage> createState() => _CalendarTasksPageState();
}

class _CalendarTasksPageState extends State<CalendarTasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<SelectedDateCubit>().selectDate(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedDateCubit, DateTime>(
      builder: (context, selectedDate) {
        return Scaffold(
          floatingActionButton: AddTaskFab(
            initialDate: selectedDate,
          ),
          body: BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HorizontalWeekdaysList(),
                  Divider(color: context.theme.dividerColor),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        //TODO: animated list here
                        for (final task in state.tasks
                            .where((t) => t.dueDate.isSameDate(selectedDate)))
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
      },
    );
  }
}
