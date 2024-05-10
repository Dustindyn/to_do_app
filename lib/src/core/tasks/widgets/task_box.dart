import 'package:animated_line_through/animated_line_through.dart';
import 'package:flutter/material.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class TaskBox extends StatefulWidget {
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  const TaskBox(
      {required this.description,
      required this.dueDate,
      required this.isCompleted,
      super.key});

  @override
  State<TaskBox> createState() => _TaskBoxState();
}

class _TaskBoxState extends State<TaskBox> {
  late bool isChecked;
  @override
  void initState() {
    super.initState();
    isChecked = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  isCrossed: isChecked,
                  child: Text(
                    widget.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                const Icon(Icons.more_vert)
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.dueDate.toString(),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Checkbox(
                  value: isChecked,
                  onChanged: (_) => setState(() => isChecked = !isChecked),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
