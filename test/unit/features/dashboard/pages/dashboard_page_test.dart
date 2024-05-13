import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';

import 'package:you_do/src/features/dashboard/pages/dashboard_page.dart';

import '../../../../mocks.dart';
import '../../../../utils/golden_utils.dart';
import '../../../util/test_util.dart';

void main() {
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
    whenListen<List<Task>>(mockTasksCubit, const Stream.empty(),
        initialState: mockTasks);
    when(() => mockTasksCubit.close()).thenAnswer((_) async {});
  });

  testGoldens('Golden test dashboard page', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
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
}
