import 'package:ambee/utils/helper/my_logger.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// Service to show Notification
class LocalNotification {
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initialSettings = const InitializationSettings(
      android: AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      ),
    );
    _notificationPlugin.initialize(initialSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
      Log.wtf('onDidReceiveNotificationResponse Function');
      Log.wtf(details.payload);
      Log.wtf(details.payload != null);
    });
  }

  static void showNotification(RemoteMessage message) {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'com.ambee.ambee',
        'weather_notification',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    _notificationPlugin.show(
      DateTime.now().microsecond,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      notificationDetails,
      payload: message.data.toString(),
    );
  }
}
