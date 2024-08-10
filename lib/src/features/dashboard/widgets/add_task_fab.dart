import 'package:flutter/material.dart';
import 'package:you_do/src/core/tasks/widgets/add_task_dialog.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class AddTaskFab extends StatelessWidget {
  final DateTime initialDate;
  const AddTaskFab({required this.initialDate, super.key});

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
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation1, _) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Center(
            child: AddTaskDialog(
              initialDate: initialDate,
            ),
          ),
        );
      },
      transitionBuilder: (context, animation1, _, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.easeInOut,
          )),
          child: child,
        );
      },
    );
  }
}
