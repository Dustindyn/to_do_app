import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

@freezed
sealed class Task with _$Task {
  const factory Task({
    required String id,
    required String description,
    required DateTime dueDate,
    required bool isCompleted,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
