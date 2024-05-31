import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:you_do/src/core/tasks/blocs/tasks_cubit.dart';
import 'package:you_do/src/core/tasks/models/task.dart';
import 'package:you_do/src/core/tasks/usecases/get_tasks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:you_do/src/core/tasks/usecases/save_tasks.dart';

//fakes
class FakeAppLocalizations extends Fake implements AppLocalizations {
  @override
  final String localeName;

  FakeAppLocalizations(this.localeName);

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      return _symbolName(invocation.memberName);
    } else if (invocation.isMethod) {
      final arguments = invocation.positionalArguments
          .map((dynamic a) => a.toString())
          .followedBy(
            invocation.namedArguments.entries.map(
              (e) => '${_symbolName(e.key)}: ${e.value}',
            ),
          )
          .join(', ');
      return '${_symbolName(invocation.memberName)}($arguments)';
    } else {
      return super.noSuchMethod(invocation);
    }
  }

  static String _symbolName(Symbol symbol) {
    final symbolString = symbol.toString();
    return symbolString.substring(8, symbolString.length - 2);
  }
}

class FakeAppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const FakeAppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.contains(locale);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      Future.value(FakeAppLocalizations(locale.toString()));

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}

//cubits
class MockTasksCubit extends MockCubit<List<Task>> implements TasksCubit {}

//usecases
class MockGetTasks extends Mock implements GetTasks {}

class MockSaveTasks extends Mock implements SaveTasks {}
