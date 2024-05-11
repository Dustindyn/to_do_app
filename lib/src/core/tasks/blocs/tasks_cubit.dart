import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/usecases/get_tasks.dart';

class TasksCubit extends Cubit<List<Task>> {
  final GetTasks _getTasks;

  TasksCubit(this._getTasks) : super([]);

  void getTasks() async {
    final tasks = await _getTasks();
    emit(tasks);
  }
}
