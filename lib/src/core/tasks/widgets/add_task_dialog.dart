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
  void initState() {
    _selectedDate = widget.initialDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.texts.add_task_new_task,
              style: context.theme.textTheme.displayLarge,
            ),
            const SizedBox(height: 24),
            TextField(
              onChanged: (value) => setState(() {
                _description = value;
              }),
              decoration: InputDecoration(
                labelText: context.texts.add_task_description,
                hintText: context.texts.add_task_hint,
                filled: true,
                fillColor: context.theme.cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: context.theme.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              style: context.theme.textTheme.bodyLarge
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(width: 4),
                        Text(
                          DateFormat('dd.MM.yyyy').format(_selectedDate),
                          style: context.theme.textTheme.displaySmall,
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
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
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: context.theme.primaryColor,
                  onPrimary: Colors.white,
                  surface: context.theme.scaffoldBackgroundColor,
                  onSurface: Colors.white,
                ),
            dialogBackgroundColor: context.theme.scaffoldBackgroundColor,
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }
}
