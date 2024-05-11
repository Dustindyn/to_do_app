import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:you_do/src/features/dashboard/pages/dashboard_page.dart';

import '../../../utils/golden_utils.dart';

void main() {
  testGoldens('Golden test dashboard page', (WidgetTester tester) async {
    await tester.pumpWidgetBuilder(
      DashboardPage(),
      wrapper: goldenWidgetWrapper,
    );
    await screenMatchesGolden(tester, "dashboard_page");
  });
}
