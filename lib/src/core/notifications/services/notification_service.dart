import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin;
  //TODO: take id as param for notifications
  const NotificationService(this.notificationPlugin);

  static Future<NotificationService> create(
      FlutterLocalNotificationsPlugin notificationPlugin) async {
    tz.initializeTimeZones();
    final service = NotificationService(notificationPlugin);
    await service.notificationPlugin.initialize(
        service._buildInitializationSettings(),
        onDidReceiveNotificationResponse:
            service._onDidReceiveNotificationResponse);
    return service;
  }

  Future<int> scheduleNotification({required String description}) async {
    const notificationId = 1;
    await notificationPlugin.zonedSchedule(
        notificationId,
        "Remember me",
        description,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    return notificationId;
  }

  Future<void> cancelNotification(int id) {
    return notificationPlugin.cancel(id);
  }

  InitializationSettings _buildInitializationSettings() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (_, __, ___, ____) =>
                print("onDidReceiveLocalNotification"));
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    return InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        macOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
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
