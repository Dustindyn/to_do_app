import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';

import '../../../../mocks.dart';

void main() {
  group("$TasksCubit", () {
    final mockGetTasks = MockGetTasks();
    final mockSaveTasks = MockSaveTasks();
    final testDate = DateTime.now();
    when(() => mockSaveTasks(any())).thenAnswer((_) async {});
    when(() => mockGetTasks()).thenAnswer((_) async => [
          Task(
              id: "1",
              description: "test",
              dueDate: testDate,
              isCompleted: false)
        ]);
    TasksCubit buildSut() => TasksCubit(mockGetTasks, mockSaveTasks);

    blocTest(
      "initial state is empty and does not emit",
      build: buildSut,
      expect: () => [],
    );

    blocTest(
      "getTasks emits tasks",
      build: buildSut,
      act: (cubit) => cubit.getTasks(),
      expect: () => [
        const TasksState.loading([]),
        TasksState.loaded([
          Task(
              id: "1",
              description: "test",
              dueDate: testDate,
              isCompleted: false)
        ]),
      ],
    );

    blocTest(
      "setTaskCompletion emits updated tasks",
      build: buildSut,
      seed: () => TasksState.loaded([
        Task(
            id: "1", description: "test", dueDate: testDate, isCompleted: false)
      ]),
      act: (cubit) => cubit.setTaskCompletion("1", true),
      expect: () => [
        TasksState.loaded([
          Task(
              id: "1",
              description: "test",
              dueDate: testDate,
              isCompleted: true)
        ])
      ],
    );

    blocTest(
      "deleteTask emits updated tasks",
      build: buildSut,
      seed: () => TasksState.loaded([
        Task(
            id: "1", description: "test", dueDate: testDate, isCompleted: false)
      ]),
      act: (cubit) => cubit.deleteTask("1"),
      expect: () => [const TasksState.loaded([])],
    );
  });
}
