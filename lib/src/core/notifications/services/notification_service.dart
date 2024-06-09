import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin;

  const NotificationService(this.notificationPlugin);

  static Future<NotificationService> create(
      FlutterLocalNotificationsPlugin notificationPlugin) async {
    final service = NotificationService(notificationPlugin);
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (_, __, ___, ____) =>
                print("onDidReceiveLocalNotification"));
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await service.notificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            service._onDidReceiveNotificationResponse);
    return service;
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      print('notification payload: $payload');
    }
    print(
        "This print is from onDidReceiveNotificationResponse from the dependencies file");
  }
}
