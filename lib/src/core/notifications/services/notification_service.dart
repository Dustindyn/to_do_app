import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:you_do/src/core/wrappers/shared_prefs_wrapper.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin;
  final SharedPrefsWrapper prefs;
  late int nextNotificationId;

  NotificationService(this.prefs, this.notificationPlugin) {
    nextNotificationId = prefs.getInt("nextNotificationId") ?? 0;
  }

  static Future<NotificationService> create(SharedPrefsWrapper prefs,
      FlutterLocalNotificationsPlugin notificationPlugin) async {
    tz.initializeTimeZones();
    final service = NotificationService(prefs, notificationPlugin);
    await service.notificationPlugin.initialize(
      service._buildInitializationSettings(),
    );

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

    await prefs.setInt("nextNotificationId", nextNotificationId + 1);
    return nextNotificationId;
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
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    return const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
  }

  Duration _getDurationUntilNotification(DateTime notificationTime) {
    return notificationTime.difference(DateTime.now());
  }
}
