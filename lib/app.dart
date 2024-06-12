import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:you_do/src/core/routing/router.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/usecases/get_tasks.dart';
import 'package:you_do/src/core/tasks/usecases/save_tasks.dart';
import 'package:you_do/src/core/theme/theme.dart';
import 'package:you_do/src/core/wrappers/shared_prefs_wrapper.dart';
import 'package:you_do/src/dependencies.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (context) => TasksCubit(
          GetTasks(context.get<SharedPrefsWrapper>()),
          SaveTasks(context.get<SharedPrefsWrapper>())),
      child: Material(
        child: MaterialApp.router(
          routerConfig: router,
          theme: theme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
