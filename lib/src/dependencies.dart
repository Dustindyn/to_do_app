import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:you_do/src/core/notifications/services/notification_service.dart';
import 'package:you_do/src/core/wrappers/shared_prefs_wrapper.dart';

Future<void> registerDependencies() async {
  final getIt = GetIt.instance;

  await registerLocalNotifications();

  getIt.registerSingleton(SharedPrefsWrapper(
    await SharedPreferences.getInstance(),
  ));
}

extension BuildContextDIX on BuildContext {
  T get<T extends Object>() => GetIt.instance<T>();
}

Future<void> registerLocalNotifications() async {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final notificationService =
      await NotificationService.create(flutterLocalNotificationsPlugin);
  GetIt.instance.registerSingleton(notificationService);
}
