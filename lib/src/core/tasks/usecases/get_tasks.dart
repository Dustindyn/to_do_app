import 'dart:convert';

import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/wrappers/shared_prefs_wrapper.dart';

class GetTasks {
  final SharedPrefsWrapper _sharedPrefsWrapper;
  const GetTasks(this._sharedPrefsWrapper);

  Future<List<Task>?> call() async {
    final tasksAsJsonStrings = _sharedPrefsWrapper.getStringList('tasks');
    if (tasksAsJsonStrings == null) {
      return [];
    }
    return tasksAsJsonStrings
        .map(
          (taskAsJsonString) => Task.fromJson(
            jsonDecode(taskAsJsonString),
          ),
        )
        .toList();
  }
}
