import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:you_do/l10n/context_text_extension.dart';
import 'package:you_do/src/core/helpers/datetime_helpers.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';
import 'package:you_do/src/features/dashboard/widgets/add_task_fab.dart';
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
        child: BlocBuilder<TasksCubit, List<Task>>(
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
                  Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 55,
                        lineWidth: 7,
                        percent: 0.25,
                        progressColor: context.theme.primaryColor,
                        backgroundColor: const Color(0xff384c5e),
                      ),
                      const SizedBox(width: 12),
                      const WeeklyChart()
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.texts.daily_tasks,
                          style: const TextStyle(fontSize: 18)),
                      Text(
                        _getCompletedTasksText(state),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //TODO: animated list here
                  for (final task in state.where((t) => t.dueDate.isToday))
                    TaskBox(
                      taskId: task.id,
                      description: task.description,
                      dueDate: task.dueDate,
                      isCompleted: task.isCompleted,
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
