import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';
import 'package:you_do/src/features/dashboard/widgets+/weekly_progress_box.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final _tasks = <Task>[
    Task(
        id: "1",
        description: "Clean the kitchen",
        dueDate: DateTime.now(),
        isCompleted: false),
    Task(
        id: "2",
        description: "Go to gym",
        isCompleted: false,
        dueDate: DateTime.now()),
    Task(
        id: "3",
        description: "Call mom",
        isCompleted: false,
        dueDate: DateTime.now()),
    Task(
      id: "4",
      description: "Bring girlfriend flowers",
      isCompleted: false,
      dueDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            const WeeklyProgressBox(),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Todays Tasks", style: TextStyle(fontSize: 18)),
                Text(
                  "1/4",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            for (var task in _tasks)
              TaskBox(
                description: task.description,
                dueDate: task.dueDate,
                isCompleted: task.isCompleted,
              )
          ],
        ),
      ),
    );
  }
}
