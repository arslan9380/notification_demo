import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  Future showNotification(
      String title, String body, DateTime scheduleTime, int id) async {
    tz.initializeTimeZones();

    var androidPlatformChannel = AndroidNotificationDetails(
      'channelId', // you can type anything its just for our own purpose
      'channelName', // you can type anything its just for our own purpose
      'channelDescription',
      // you can type anything its just for our own purpose
      importance: Importance.max,
      //This is the place where you can do setting of notification for android like i did.
    );

    var iOSPlatformChannel = IOSNotificationDetails(
        //This is the place where you can do setting of notification for Ios but here i go with default
        );

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannel, iOS: iOSPlatformChannel);

    await FlutterLocalNotificationsPlugin().zonedSchedule(
        id,
        //Id should be unique if you use same if for different notifications it will dismiss the 1st notification.
        title, // Title of your notification whatever you want
        body, // body of your notification whatever you want
        tz.TZDateTime.from(scheduleTime, tz.local),
        // schedule time is our time on which time we want notification
        platformChannelSpecifics,
        //here we'll have to provide  our settings we prepared above
        matchDateTimeComponents: DateTimeComponents.time,
        // this is type of notification which we define "DateTimeComponents.time" which schedule the notification for everyday on same time we give above named as scheduleTime.
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
