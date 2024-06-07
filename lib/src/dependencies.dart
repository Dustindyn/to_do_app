import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: (_, __, ___, ____) =>
              print("onDidReceiveLocalNotification"));
  const LinuxInitializationSettings initializationSettingsLinux =
      LinuxInitializationSettings(defaultActionName: 'Open notification');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

  GetIt.instance.registerSingleton(flutterLocalNotificationsPlugin);
}

void onDidReceiveNotificationResponse(
    NotificationResponse notificationResponse) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: $payload');
  }
  print(
      "This print is from onDidReceiveNotificationResponse from the dependencies file");
}
