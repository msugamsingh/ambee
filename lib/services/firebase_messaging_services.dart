import 'package:ambee/services/notification_services.dart';
import 'package:ambee/utils/helper/my_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingServices {
  static Future<void> initialize() async {
    await FirebaseMessagingServices.getFcmToken();
    await FirebaseMessagingServices.setForegroundNotificationOptions();
    await FirebaseMessagingServices.onBackgroundMessage();
    await FirebaseMessagingServices.onMessage();
  }

  // NOTIFICATION
  static Future<void> getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Log.i(('fcmToken', fcmToken));
  }

  static Future<void> setForegroundNotificationOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // listens to foreground messages, In-app Notifications
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Log.i(message.data);
      LocalNotification.showNotification(message);
      if (message.notification != null) {
        Log.i(message.notification);

        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> setupInteractedMessage() async {
    // when app is opened from terminated state
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // when app is in background state
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  static void _handleMessage(RemoteMessage message) {
    // can get data from notification
    // if (message.data['lat'] != null) {
    // do stuff
    // }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    LocalNotification.showNotification(message);

    print("Handling a background message: ${message.data}");
  }
}
