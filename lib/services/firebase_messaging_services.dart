import 'package:ambee/services/notification_services.dart';
import 'package:ambee/utils/helper/my_logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// A service class for handling Firebase Cloud Messaging (FCM) in Flutter.
class FirebaseMessagingServices {
  /// Initializes Firebase Cloud Messaging services.
  ///
  /// This method initializes FCM and configures various messaging options.
  /// It should be called when the app starts to enable FCM functionality.
  static Future<void> initialize() async {
    await FirebaseMessagingServices.getFcmToken();
    await FirebaseMessagingServices.setForegroundNotificationOptions();
    await FirebaseMessagingServices.onBackgroundMessage();
    await FirebaseMessagingServices.onMessage();
  }

  /// Retrieves the FCM token for the device.
  ///
  /// The FCM token is a unique identifier for the device that can be used
  /// to send push notifications to the device.
  static Future<void> getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    Log.i(('fcmToken', fcmToken));
  }

  /// Sets the foreground notification presentation options.
  ///
  /// This method configures how notifications are displayed when the app is in the foreground.
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

  /// Sets up the background message handler for FCM.
  ///
  /// This method registers a background message handler that is called when
  /// the app receives an FCM message while running in the background.
  static Future<void> onBackgroundMessage() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// Sets up the message handler for when the app is opened from a terminated state.
  ///
  /// This method handles FCM messages when the app is launched from a terminated state.
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
