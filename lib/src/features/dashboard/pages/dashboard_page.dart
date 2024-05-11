import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';

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
    return SingleChildScrollView(
      child: BlocBuilder<TasksCubit, List<Task>>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 150),
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
                const SizedBox(
                  height: 12,
                ),
                for (final task in state)
                  TaskBox(
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
    );
  }
}
