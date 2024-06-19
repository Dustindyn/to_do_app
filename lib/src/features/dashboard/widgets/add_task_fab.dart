import 'package:flutter/material.dart';
import 'package:you_do/src/core/tasks/widgets/add_task_dialog.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class AddTaskFab extends StatelessWidget {
  final DateTime? initialDate;
  const AddTaskFab({this.initialDate, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _openAddTaskDialog(context),
      backgroundColor: context.theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Icon(Icons.add, size: 32),
    );
  }

  void _openAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(
          initialDate: initialDate,
        );
      },
    );
  }
}
