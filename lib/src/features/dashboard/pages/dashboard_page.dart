import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/l10n/context_text_extension.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/features/dashboard/widgets/add_task_fab.dart';
import 'package:you_do/src/features/dashboard/widgets/daily_progress_indicator.dart';
import 'package:you_do/src/features/dashboard/widgets/weekly_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<TasksCubit>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const AddTaskFab(),
      body: SingleChildScrollView(
        child: BlocConsumer<TasksCubit, TasksState>(
          listener: (context, state) => state.maybeWhen(
            error: (tasks) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: context.theme.colorScheme.error,
                  margin: const EdgeInsets.all(12),
                  content: Row(children: [
                    const Icon(Icons.error, color: Colors.white),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(context.texts.error_tasks,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ]),
                ),
              );
              return null;
            },
            orElse: () {
              return null;
            },
          ),
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.texts.dashboard,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      DailyProgressIndicator(),
                      SizedBox(width: 12),
                      WeeklyChart()
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.texts.daily_tasks,
                          style: const TextStyle(fontSize: 18)),
                      Text(
                        _getCompletedTasksText(state.tasks),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //TODO: animated list here
                  for (final task
                      in state.tasks.where((t) => t.dueDate.isToday))
                    TaskBox(
                      taskId: task.id,
                    ),
                  const SizedBox(height: 64),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  String _getCompletedTasksText(List<Task> tasks) {
    return "${tasks.where((t) => t.isCompleted).length}/${tasks.length}";
  }
}
