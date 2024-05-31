import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_do/src/core/wrappers/shared_prefs_wrapper.dart';

Future<void> registerDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton(SharedPrefsWrapper(
    await SharedPreferences.getInstance(),
  ));
}

extension BuildContextDIX on BuildContext {
  T get<T extends Object>() => GetIt.instance<T>();
}
