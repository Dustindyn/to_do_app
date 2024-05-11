import 'package:you_do/src/core/tasks/models/task.dart';

class GetTasks {
  const GetTasks();

  Future<List<Task>> call() async {
    return [
      Task(
          id: "1",
          description: "Clean the kitchen",
          dueDate: DateTime.now(),
          isCompleted: false),
      Task(
          id: "2",
          description: "Go to gym",
          isCompleted: false,
          dueDate: DateTime.now()),
      Task(
          id: "3",
          description: "Call mom",
          isCompleted: false,
          dueDate: DateTime.now()),
      Task(
          id: "4",
          description: "Wash dishes",
          isCompleted: false,
          dueDate: DateTime.now()),
    ];
  }
}
