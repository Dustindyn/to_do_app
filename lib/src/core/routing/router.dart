import 'package:go_router/go_router.dart';

import 'package:you_do/src/core/scaffolds/main_scaffold.dart';
import 'package:you_do/src/features/dashboard/pages/dashboard_page.dart';
import 'package:you_do/src/features/calendar_tasks/pages/calendar_tasks_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainScaffold(
        navigationShell: navigationShell,
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/todos',
              builder: (context, state) => const CalendarTasksPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
