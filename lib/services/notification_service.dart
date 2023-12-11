part of 'services.dart';
final navkey = GlobalKey<NavigatorState>();
class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    _configureLocalTimezone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
       final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
      handleMessage(message);
    });
  }

  Future<void> displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'medicine_app', 'medreminder',
        importance: Importance.max, priority: Priority.high, icon: 'appicon');
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  scheduledNotification(int hour, int minutes, m.Remind remind) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        remind.id!.toInt(),
        remind.title,
        remind.dose,
        _convertTime(hour, minutes),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('medicine_app', 'medreminder',
                importance: Importance.max, priority: Priority.high, icon: 'appicon')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${remind.title}|" + "${remind.dose}|");
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future selectNotification(payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    if (payload == "Theme Changed") {
    } else {
      // Get.to(()=>NotifiedPage(label:payload));
    }
  }
   static void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navkey.currentState?.push(
      MaterialPageRoute(
        builder: (context) =>  NotifiedPage(label: message),
        settings: RouteSettings(arguments: message),
      ),
    );
  }
}
