import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin;
  //TODO: next notificationId should be stored in shared prefs so you dont use same id if you schedule across app starts
  int nextNotificationId = 0;

  NotificationService(this.notificationPlugin);

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

  Future<int> scheduleNotification(DateTime dateTime, String title,
      {required String description}) async {
    final durationUntilNotification = _getDurationUntilNotification(dateTime);
    await notificationPlugin.zonedSchedule(
        nextNotificationId,
        title,
        description,
        tz.TZDateTime.now(tz.local).add(durationUntilNotification),
        const NotificationDetails(
          android: AndroidNotificationDetails('1', 'YouDoLocalNotifications',
              channelDescription: 'Local Notifications for the YouDo App'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    return nextNotificationId++;
  }

  Future<void> cancelNotification(int id) {
    return notificationPlugin.cancel(id);
  }

  Future<bool> hasPermission() {
    return Permission.notification.request().isGranted;
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

  Duration _getDurationUntilNotification(DateTime notificationTime) {
    return notificationTime.difference(DateTime.now());
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
