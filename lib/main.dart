import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_demo/schdeule_notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// This is function you need to call in project
  /// in which you want to have notifications.
  initNotification();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScheduleNotification(),
    );
  }
}

Future initNotification() async {
  ///Step 1: Android  initialization
  var initializationSettingsAndroid =
      AndroidInitializationSettings("@mipmap/ic_launcher");

  ///Step 2: Ios  initialization
  var initializationSettingsIOS = IOSInitializationSettings();

  /// Step3: Preparing setting
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  ///step4: initialization of plugin with setting
  await FlutterLocalNotificationsPlugin().initialize(initializationSettings,
      onSelectNotification: (payload) async {
    ///This notification excecuted when you come to the app by clicking on notification
    return;
  });
}
