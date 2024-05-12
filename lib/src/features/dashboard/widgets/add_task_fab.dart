import 'package:flutter/material.dart';

class AddTaskFab extends StatelessWidget {
  const AddTaskFab({super.key});

  @override
  Widget build(BuildContext context) {
    return const FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    );
  }
}
