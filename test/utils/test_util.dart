import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_do/src/core/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../mocks.dart';

Widget wrapWidget(Widget child, {List<BlocProvider> blocProviders = const []}) {
  return MaterialApp(
      theme: theme,
      home: Localizations(
        delegates: [
          const FakeAppLocalizationsDelegate(),
          ...AppLocalizations.localizationsDelegates.skip(1),
        ],
        locale: const Locale('en'),
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: blocProviders.isNotEmpty
              ? MultiBlocProvider(
                  providers: blocProviders,
                  child: child,
                )
              : child,
        ),
      ));
}
