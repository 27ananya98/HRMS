import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

String firebaseToken = "";

class FirebaseConfig {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Create a [AndroidNotificationChannel] for heads up notifications
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  FirebaseConfig();

  config() async {
    NotificationSettings permission =
        await _firebaseMessaging.requestPermission();
    debugPrint('PERMISSION STATUS : ${permission.authorizationStatus}');

    flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings("logo"),
            iOS: DarwinInitializationSettings(
                requestSoundPermission: true,
                requestAlertPermission: true,
                requestBadgePermission: true,
                defaultPresentAlert: true,
                defaultPresentBadge: true,
                defaultPresentSound: true)),
        onDidReceiveNotificationResponse: notificationTapBackground);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );

    if (Platform.isAndroid) {
      firebaseToken = await _firebaseMessaging.getToken() ?? '';
    } else if (Platform.isIOS) {
      // iOS-specific code
      // String iosToken = await _firebaseMessaging.getAPNSToken() ?? '';
      //print('IOS APNS TOKEN : $iosToken');
      firebaseToken = await _firebaseMessaging.getToken() ?? '';
    }
    debugPrint('Firebase Token : ${firebaseToken.trim()}');
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      //.......called when app starts .......//
      debugPrint('Firebase Initial Message : $message');
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //..........called when app in foreground...........//
      debugPrint('Received Message : ${message.notification?.body!}');
      processNotification(
          message, flutterLocalNotificationsPlugin, message.notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      //..........When App comes to Foreground from background..................//
      debugPrint('A new onMessageOpenedApp event was published!');
      try {
        Map map = message.data;
        debugPrint("on Message opened app $map");
      } catch (e) {
        debugPrint("$e");
      }
    });
  }

  Future handleNotificationClick(String? payload) async {
    try {
      Map dataMap = jsonDecode(payload!);
      debugPrint("on Message opened app $dataMap");
    } catch (e) {
      debugPrint("$e");
    }
    return Future.value();
  }

  Future<void> processNotification(
      RemoteMessage message,
      FlutterLocalNotificationsPlugin? plugin,
      RemoteNotification? notification) async {
    Map map = message.data;
    debugPrint("Process notification $map");
    showNotification(message, plugin, notification);
  }

  showNotification(
      RemoteMessage message,
      FlutterLocalNotificationsPlugin? plugin,
      RemoteNotification? notification) {
    Map map = message.data;
    String payloadData = jsonEncode(map);
    try {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        plugin!
            .show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    icon: 'logo',
                  ),
                ),
                payload: payloadData)
            .catchError((e) => debugPrint('NOTIFICATION ERROR : $e'));
      }
    } catch (e) {
      debugPrint("$e");
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin2 =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin2.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings("logo"),
          iOS: DarwinInitializationSettings()),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  debugPrint('Handling a background message ${message.data}');
  try {
    Map map = message.data;
    debugPrint("on Message opened app $map");
  } catch (e) {
    debugPrint("Firebase messaging background handler exception $e");
  }
}

void notificationTapBackground(NotificationResponse notificationResponse) {
  debugPrint("On notification tap background $notificationResponse");
}

Future handleBackgroundNotificationClick(String? payload) async {
  // bool isLoggedIn =
  //     await AppPreferences().getBoolSharedPreferences(AppConstants.isLoggedIn);
  if (true) {
    try {
      debugPrint('On Background Notification CLick ');
    } catch (e) {
      debugPrint('Notification Click Error : $e');
    }
  } else {}
  return Future.value();
}
