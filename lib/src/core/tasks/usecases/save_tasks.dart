import 'dart:convert';

import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/wrappers/shared_prefs_wrapper.dart';

class SaveTasks {
  final SharedPrefsWrapper _sharedPrefsWrapper;

  SaveTasks(this._sharedPrefsWrapper);

  Future<void> call(List<Task> tasks) async {
    //TODO: move key to a config file or similar
    final tasksAsJsonStrings =
        tasks.map((task) => jsonEncode(task.toJson())).toList();
    await _sharedPrefsWrapper.setStringList('tasks', tasksAsJsonStrings);
  }
}
