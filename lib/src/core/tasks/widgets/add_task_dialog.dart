import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog({super.key});

  DateTime? _selectedDate;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 128),
      child: Container(
        color: context.theme.scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("New Task", style: context.theme.textTheme.displayLarge),
              TextField(
                onChanged: (value) => _description = value,
                decoration: const InputDecoration(
                  labelText: "Description",
                  hintText: "Enter task description",
                ),
              ),
              TextButton(
                onPressed: () => _getDate(context),
                child: const Text("Select Date"),
              ),
              ElevatedButton(
                  onPressed: () {
                    context.read<TasksCubit>().addTask(
                          description: _description!,
                          dueDate: _selectedDate!,
                        );
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add Task")),
            ],
          ),
        ),
      ),
    );
  }

  void _getDate(BuildContext context) async {
    _selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }
}
