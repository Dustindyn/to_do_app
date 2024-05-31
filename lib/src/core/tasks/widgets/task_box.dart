import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class TaskBox extends StatefulWidget {
  final String taskId;

  const TaskBox({required this.taskId, super.key});

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Card(
          color: context.theme.cardColor,
          child: Container(
            width: size.width,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedLineThrough(
                      duration: const Duration(milliseconds: 400),
                      isCrossed: _getIsChecked(state.tasks),
                      child: Text(
                        _getDescription(state.tasks),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      child: const Icon(Icons.close, color: Colors.grey),
                      onTap: () =>
                          context.read<TasksCubit>().deleteTask(widget.taskId),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getDueDate(state.tasks).toString(),
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    Checkbox(
                      side: WidgetStateBorderSide.resolveWith(
                        (states) =>
                            const BorderSide(width: 1.0, color: Colors.grey),
                      ),
                      value: _getIsChecked(state.tasks),
                      onChanged: (_) {
                        setState(() {
                          context.read<TasksCubit>().setTaskCompletion(
                              widget.taskId, !_getIsChecked(state.tasks));
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _getIsChecked(List<Task> tasks) {
    final task = tasks.firstWhere((task) => task.id == widget.taskId);
    return task.isCompleted;
  }

  DateTime _getDueDate(List<Task> tasks) {
    final task = tasks.firstWhere((task) => task.id == widget.taskId);
    return task.dueDate;
  }

  String _getDescription(List<Task> tasks) {
    final task = tasks.firstWhere((task) => task.id == widget.taskId);
    return task.description;
  }
}
