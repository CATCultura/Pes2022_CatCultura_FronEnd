import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart';


class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  List<String?> scheduledNotifications = <String>[];

  factory NotificationService(){
     return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async{
    final IOSInitializationSettings iosInitializationSettings = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(iOS: iosInitializationSettings,
        android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotifications(String? notiId, String title, String body,) async {
    initializeTimeZones();
    var timeZone = getLocation('Europe/Madrid');
    setLocalLocation(timeZone);
    if(notiId != null) {
      scheduledNotifications.add(notiId);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          int.parse(notiId), title, body,
          TZDateTime.now(local).add(Duration(seconds: 1)),
          const NotificationDetails(
              android: AndroidNotificationDetails('main_channel',
                  'Main Channel',
                  channelDescription: 'Main Channel Notificaions',
                  importance: Importance.max,
                  priority: Priority.max,
                  icon: '@mipmap/ic_launcher'),
              iOS: IOSNotificationDetails(sound: 'default.wav',
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true)
          ),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
              .absoluteTime,
          androidAllowWhileIdle: true);
    }
  }

  Future<void> showScheduledNotifications(String? notiId, String title, String body, DateTime selectedDate, TimeOfDay selectedTime) async {
    DateTime newDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    int segons= newDateTime.difference(DateTime.now()).inSeconds;
    initializeTimeZones();
    var timeZone = getLocation('Europe/Madrid');
    setLocalLocation(timeZone);
    if(notiId != null) {
      scheduledNotifications.add(notiId);
      await flutterLocalNotificationsPlugin.zonedSchedule(
          int.parse(notiId), title, body,
          TZDateTime.now(local).add(Duration(seconds: segons)),
          const NotificationDetails(
              android: AndroidNotificationDetails('main_channel',
                  'Main Channel',
                  channelDescription: 'Main Channel Notificaions',
                  importance: Importance.max,
                  priority: Priority.max,
                  icon: '@mipmap/ic_launcher'),
              iOS: IOSNotificationDetails(sound: 'default.wav',
                  presentAlert: true,
                  presentBadge: true,
                  presentSound: true)
          ),
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation
              .absoluteTime,
          androidAllowWhileIdle: true);
    }
  }

  Future<void> deleteOneNotification(String? notiId) async{
    if(notiId != null && scheduledNotifications.contains(notiId)) await flutterLocalNotificationsPlugin.cancel(int.parse(notiId));
  }
}