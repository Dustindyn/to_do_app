import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:you_do/src/core/routing/router.dart';
import 'package:you_do/src/core/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: theme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
      ],
    );
  }
}
