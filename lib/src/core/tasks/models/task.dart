import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const factory Task({
    required String id,
    required String description,
    required DateTime dueDate,
    required bool isCompleted,
  }) = _Task;
}
