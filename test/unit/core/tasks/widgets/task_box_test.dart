import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:you_do/src/core/tasks/widgets/task_box.dart';

import '../../../../utils/golden_utils.dart';
import '../../../../utils/test_util.dart';

void main() {
  testGoldens('Golden test task box', (WidgetTester tester) async {
    final builder = getGoldenColumnBuilder()
      ..addScenario(
        "checked",
        TaskBox(
          description: "Clean the kitchen",
          dueDate: DateTime.now(),
          isCompleted: true,
        ),
      )
      ..addScenario(
        "unchecked",
        TaskBox(
          description: "Clean the kitchen",
          dueDate: DateTime.now(),
          isCompleted: false,
        ),
      );
    await tester.pumpWidgetBuilder(builder.build(), wrapper: wrapWidget);
    await screenMatchesGolden(tester, "task_box");
  });
}
