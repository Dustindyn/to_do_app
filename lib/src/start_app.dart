import 'package:flutter/widgets.dart';
import 'package:you_do/src/dependencies.dart';

Future<void> startApp(Widget app) async {
  WidgetsFlutterBinding.ensureInitialized();
  await registerDependencies();
  runApp(app);
}
