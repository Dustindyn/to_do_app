import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension ContextTextExtension on BuildContext {
  AppLocalizations get texts => AppLocalizations.of(this)!;
}
