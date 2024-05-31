import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/usecases/get_tasks.dart';
import 'package:you_do/src/core/tasks/usecases/save_tasks.dart';

class TasksCubit extends Cubit<List<Task>> {
  final GetTasks _getTasks;
  final SaveTasks _saveTasks;

  TasksCubit(this._getTasks, this._saveTasks) : super([]);

  void getTasks() async {
    final tasks = await _getTasks() ?? [];
    emit(tasks);
  }

  //TODO: add rollback if savetasks fails
  void setTaskCompletion(String taskId, bool isCompleted) {
    final task = state.firstWhere((task) => task.id == taskId);
    final updatedTask = task.copyWith(isCompleted: isCompleted);
    final updatedTasks =
        state.map((t) => t.id == taskId ? updatedTask : t).toList();
    emit(updatedTasks);
    _saveTasks(updatedTasks);
  }

  void deleteTask(String taskId) {
    final updatedTasks = state.where((task) => task.id != taskId).toList();
    emit(updatedTasks);
    _saveTasks(updatedTasks);
  }

  void addTask({required String description, required DateTime dueDate}) {
    final newTask = Task(
      id: DateTime.now().toIso8601String(),
      description: description,
      dueDate: dueDate,
      isCompleted: false,
    );
    final updatedTasks = [...state, newTask];
    emit(updatedTasks);
    _saveTasks(updatedTasks);
  }
}
