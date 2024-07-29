import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';

import '../../../../mocks.dart';
import '../../../../utils/golden_utils.dart';
import '../../../../utils/test_util.dart';

void main() {
  testGoldens('Golden test task box', (WidgetTester tester) async {
    final builder = getGoldenColumnBuilder()
      ..addScenario(
        "checked",
        TaskBox(
          Task(
            id: "1",
            description: "test description",
            isCompleted: true,
            dueDate: DateTime(2024),
          ),
        ),
      )
      ..addScenario(
        "unchecked",
        TaskBox(
          Task(
            id: "1",
            description: "test description",
            isCompleted: false,
            dueDate: DateTime(2024),
          ),
        ),
      );
    await tester.pumpWidgetBuilder(
      builder.build(),
      wrapper: (child) => wrapWidget(
        child,
        blocProviders: [
          BlocProvider<TasksCubit>(
            create: (context) => TasksCubit(
              MockGetTasks(),
              MockSaveTasks(),
            ),
          )
        ],
      ),
    );
    await screenMatchesGolden(tester, "task_box");
  });
}
