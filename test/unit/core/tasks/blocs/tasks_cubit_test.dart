import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';

import '../../../../mocks.dart';

void main() {
  group("$TasksCubit", () {
    final mockGetTasks = MockGetTasks();
    final testDate = DateTime.now();
    when(() => mockGetTasks()).thenAnswer((_) async => [
          Task(
              id: "1",
              description: "test",
              dueDate: testDate,
              isCompleted: false)
        ]);
    TasksCubit buildSut() => TasksCubit(mockGetTasks);

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
        [
          Task(
              id: "1",
              description: "test",
              dueDate: testDate,
              isCompleted: false)
        ]
      ],
    );

    blocTest(
      "setTaskCompletion emits updated tasks",
      build: buildSut,
      seed: () => [
        Task(
            id: "1", description: "test", dueDate: testDate, isCompleted: false)
      ],
      act: (cubit) => cubit.setTaskCompletion("1", true),
      expect: () => [
        [
          Task(
              id: "1",
              description: "test",
              dueDate: testDate,
              isCompleted: true)
        ]
      ],
    );

    blocTest(
      "deleteTask emits updated tasks",
      build: buildSut,
      seed: () => [
        Task(
            id: "1", description: "test", dueDate: testDate, isCompleted: false)
      ],
      act: (cubit) => cubit.deleteTask("1"),
      expect: () => [[]],
    );

    blocTest(
      "addTask emits updated tasks",
      build: buildSut,
      act: (cubit) => cubit.addTask(description: "test", dueDate: testDate),
      expect: () => [
        [
          isA<Task>()
              .having((t) => t.description, "description", "test")
              .having((t) => t.dueDate, "dueDate", testDate)
              .having((t) => t.isCompleted, "isCompleted", false),
        ]
      ],
    );
  });
}
