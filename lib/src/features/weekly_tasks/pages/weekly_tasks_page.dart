import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:you_do/src/features/dashboard/widgets/add_task_fab.dart';
import 'package:you_do/src/features/weekly_tasks/widgets/horizontal_weekdays_list.dart';

class WeeklyTasksPage extends StatefulWidget {
  const WeeklyTasksPage({super.key});

  @override
  State<WeeklyTasksPage> createState() => _WeeklyTasksPageState();
}

class _WeeklyTasksPageState extends State<WeeklyTasksPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: AddTaskFab(),
      body: Column(
        children: [SizedBox(height: 100, child: HorizontalWeekdaysList())],
      ),
    );
  }
}
