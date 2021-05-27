import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:testchat/screens/message_screen.dart';
import 'package:testchat/services/navigator_service.dart';

class NotificationService {
  static const keyMessageChannel = 'key_message';

  final BuildContext context;
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService(this.context);

  void init() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('show_icon');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    print('notification service ===> $payload');
    switch (payload) {
      case keyMessageChannel:
        NavigatorService(context).pushToWidget(screen: MessageScreen());
        break;
    }
  }

  static void showNotification(
      String title, String description, String type) async {
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, description, platform,
        payload: type);
  }
}
