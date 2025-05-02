import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications{

  //Create an object

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  //

  // initialize the variable;

  void initState() {
     var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
  //

  Future<void> _showNotification(sTitle,sMessage) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'location_channel',
      'Location updates',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      sTitle,
      sMessage,
      platformChannelSpecifics,
    );
  }

}