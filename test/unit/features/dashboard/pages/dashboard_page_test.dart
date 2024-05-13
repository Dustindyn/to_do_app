import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';

import 'package:you_do/src/features/dashboard/pages/dashboard_page.dart';

import '../../../../mocks.dart';
import '../../../../utils/test_util.dart';

void main() {
  group('Dashboard Page', () {
    final mockTasksCubit = MockTasksCubit();
    final List<Task> mockTasks = <Task>[
      Task(
        id: "1",
        description: "Clean the kitchen",
        dueDate: DateTime.now(),
        isCompleted: false,
      ),
      Task(
        id: "2",
        description: "Buy groceries",
        dueDate: DateTime.now(),
        isCompleted: false,
      ),
    ];

    setUpAll(() {
      reset(mockTasksCubit);
      whenListen<List<Task>>(mockTasksCubit, const Stream.empty(),
          initialState: mockTasks);
      when(() => mockTasksCubit.close()).thenAnswer((_) async {});
    });

    testGoldens('Golden test dashboard page', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const DashboardPage(),
          blocProviders: [
            BlocProvider<TasksCubit>(
              create: (_) => mockTasksCubit,
            ),
          ],
        ),
      );
      await screenMatchesGolden(tester, "dashboard_page");
    });

    testWidgets('loads tasks on init', (tester) async {
      await tester.pumpWidget(
        wrapWidget(
          const DashboardPage(),
          blocProviders: [
            BlocProvider<TasksCubit>(
              create: (_) => mockTasksCubit,
            ),
          ],
        ),
      );
      verify(() => mockTasksCubit.getTasks()).called(1);
    });
  });
}
