import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/usecases/get_tasks.dart';
import 'package:you_do/src/core/tasks/usecases/save_tasks.dart';

part 'tasks_cubit.freezed.dart';

@freezed
sealed class TasksState with _$TasksState {
  const factory TasksState.initial(List<Task> tasks) = _Initial;
  const factory TasksState.loading(List<Task> tasks) = _Loading;
  const factory TasksState.loaded(List<Task> tasks) = _Loaded;
  const factory TasksState.error(List<Task> tasks) = _Error;
}

class TasksCubit extends Cubit<TasksState> {
  final GetTasks _getTasks;
  final SaveTasks _saveTasks;

  TasksCubit(this._getTasks, this._saveTasks)
      : super(const TasksState.initial([]));

  void getTasks() async {
    try {
      emit(const TasksState.loading([]));
      final tasks = await _getTasks() ?? [];
      emit(TasksState.loaded(tasks));
    } catch (e) {
      emit(TasksState.error(state.tasks));
    }
  }

  //TODO: add rollback if savetasks fails
  Future<void> setTaskCompletion(String taskId, bool isCompleted) async {
    final rollbackState = state.tasks;
    try {
      final task = state.tasks.firstWhere((task) => task.id == taskId);
      final updatedTask = task.copyWith(isCompleted: isCompleted);
      final updatedTasks =
          state.tasks.map((t) => t.id == taskId ? updatedTask : t).toList();
      emit(TasksState.loaded(updatedTasks));
      await _saveTasks(updatedTasks);
    } on Exception catch (e) {
      emit(TasksState.error([...rollbackState]));
    }
  }

  void deleteTask(String taskId) async {
    final rollbackState = state.tasks;
    try {
      final updatedTasks =
          state.tasks.where((task) => task.id != taskId).toList();
      emit(TasksState.loaded(updatedTasks));
      await _saveTasks(updatedTasks);
    } on Exception catch (e) {
      emit(TasksState.error([...rollbackState]));
    }
  }

  void addTask({required String description, required DateTime dueDate}) async {
    final rollbackState = state.tasks;
    try {
      final newTask = Task(
        id: DateTime.now().toIso8601String(),
        description: description,
        dueDate: dueDate,
        isCompleted: false,
      );
      final updatedTasks = [...state.tasks, newTask];
      emit(TasksState.loaded(updatedTasks));
      await _saveTasks(updatedTasks);
    } on Exception catch (e) {
      emit(TasksState.error([...rollbackState]));
    }
  }
}
