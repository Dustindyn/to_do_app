import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/l10n/context_text_extension.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  DateTime? _selectedDate;

  String? _description;

  @override
  Widget build(BuildContext context) {
    //TODO: make this not ugly
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 128),
      child: Container(
        color: context.theme.scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(context.texts.add_task_new_task,
                  style: context.theme.textTheme.displayLarge),
              TextField(
                onChanged: (value) => setState(() {
                  _description = value;
                }),
                decoration: InputDecoration(
                  labelText: context.texts.add_task_description,
                  hintText: context.texts.add_task_hint,
                ),
              ),
              TextButton(
                onPressed: () => _getDate(context),
                child: const Text("Select Date"),
              ),
              ElevatedButton(
                onPressed: _description != null && _selectedDate != null
                    ? () {
                        context.read<TasksCubit>().addTask(
                              description: _description!,
                              dueDate: _selectedDate!,
                            );
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text(
                  context.texts.add_task_submit,
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _getDate(BuildContext context) async {
    //TODO: change calendar color to match scaffold color
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    setState(() {
      _selectedDate = date;
    });
  }
}
