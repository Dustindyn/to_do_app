import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:you_do/l10n/context_text_extension.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class AddTaskDialog extends StatefulWidget {
  final DateTime initialDate;
  const AddTaskDialog({required this.initialDate, super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String? _description;
  late DateTime _selectedDate;

  @override
  initState() {
    _selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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
            const SizedBox(height: 24),
            Row(
              children: [
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: context.theme.primaryColor),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 4),
                        Text(DateFormat('dd.MM.yyyy').format(_selectedDate),
                            style: context.theme.textTheme.displaySmall)
                      ],
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: _description != null
                  ? () {
                      context.read<TasksCubit>().addTask(
                            description: _description!,
                            dueDate: _selectedDate,
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
    );
  }

  void _selectDate(BuildContext context) async {
    //TODO: change calendar color to match scaffold color
    final date = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }
}
