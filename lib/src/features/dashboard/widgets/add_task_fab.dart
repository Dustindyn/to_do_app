import 'package:flutter/material.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class AddTaskFab extends StatelessWidget {
  const AddTaskFab({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: context.theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Icon(Icons.add, size: 32),
    );
  }
}
