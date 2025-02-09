import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  RxString notificationTitle = "No New Notification".obs;
  RxString notificationBody = "".obs;
  final isPermissionGranted = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initializeNotifications();
    isPermissionGranted.value = await checkNotificationPermission();
  }

  Future<void> initializeNotifications() async {
    await Firebase.initializeApp();

    // Set background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Request notification permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission for notifications');
      }
    }

    // Get FCM token
    _firebaseMessaging.getToken().then((token) {
      if (kDebugMode) {
        print("FCM Token: $token");
      }
      // Save token to Firestore if needed
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Foreground Message: ${message.notification?.title}");
      }
      notificationTitle.value =
          message.notification?.title ?? "New Notification";
      notificationBody.value =
          message.notification?.body ?? "You have a new update";
      _showLocalNotification(message);
    });

    // Initialize local notifications
    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings =
        InitializationSettings(android: androidInitSettings);
    await _flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // Background message handler
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    if (kDebugMode) {
      print("Handling background message: ${message.messageId}");
    }
  }

  Future<bool> checkNotificationPermission() async {
    final bool? granted = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled();

    if (granted == true) {
      if (kDebugMode) {
        print("✅ Notifications are enabled!");
      }
    } else {
      if (kDebugMode) {
        print("❌ Notifications are NOT enabled!");
      }
    }
    return granted ?? false;
  }

  Future<void> requestNotificationPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestNotificationsPermission();
  }

  // Show a local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      '456',
      // 'channel_id',
      'Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? "New Notification",
      message.notification?.body ?? "You have a new update",
      notificationDetails,
    );
  }

  Future<void> scheduleNotification(DateTime scheduledTime) async {
    if (!isPermissionGranted.value) {
      await requestNotificationPermission();
    }
    final tz.TZDateTime tzScheduledTime =
        tz.TZDateTime.from(scheduledTime, tz.local);

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'medication_channel',
      'Medicine Reminders',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0, // Notification ID
      'Medicine Reminder',
      'Time to take your medicine!',
      tzScheduledTime,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
