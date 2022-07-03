import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:reference_project_flutter/features/notification_custom/changeImage.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  // define notification_custom plugin
  static final _notification = FlutterLocalNotificationsPlugin();

  // onClick Notification ? and send Data .
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    // small image for notification_custom
    final largeIconPath = await Utils.downloadFile(
        'https://images.unsplash.com/photo-1656828051768-5ef859415a89?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
        'largeIconPath');

    // big image for notification_custom
    final bigPicture = await Utils.downloadFile(
        'https://images.unsplash.com/photo-1656824249722-65d681fbde4f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=60',
        'bigPicture');

    // style notification_custom ( small icon and large after swipe )
    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicture),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    String sound = 'sound.wav';
    // channels .
    return NotificationDetails(
      android: AndroidNotificationDetails(
        // If you want to show the entire notification_custom instead of a specific part disable Importance.max and change id channel etc => id 2
        'channel id 3',
        'channel name',
        // add image to notification_custom
        styleInformation: styleInformation,
        importance: Importance.max,
        priority: Priority.high,

        // add custom sound to notification_custom | sound + enableVibration |.
        sound: RawResourceAndroidNotificationSound(sound.split('.')[0]),
        enableVibration: false,
      ),
      iOS: const IOSNotificationDetails(
        sound: 'sound.wav',
      ),
    );
  }

  static Future init({bool initSchedule = false}) async {
    // Initialization
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios);

    // when close application , send notification_custom to user .
    final details = await _notification.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await _notification.initialize(
      settings,
      // on click notification_custom .
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );

    if (initSchedule) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  // show notification_custom .
  static Future showNotification(
      {String? title, String? body, String? payload, int id = 0}) async {
    _notification.show(id, title, body, await _notificationDetails(),
        payload: payload);
  }

  static Future showScheduleNotification(
      {String? title,
        String? body,
        String? payload,
        int id = 5,
        required DateTime dateTime}) async {
    _notification.zonedSchedule(
      id,
      title,
      body,

      // send daily notification_custom |  hour 2 => you can use 2 , 30 = 2:30
      _scheduleDaily(Time(12, 54)),

      // ------- OR ----------

      // send weekly notification_custom .(select days and time)
      // _scheduleWeekly(Time(14,55),days:[DateTime.saturday , DateTime.sunday]),

      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      // if you can use DateTimeComponents.time if send daily notification_custom .
      // send Week notification_custom dayOfWeekAndTime .
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);

    // if DateTime is 1:25am , then it will be 1:25am tomorrow .
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(seconds: 15))
        : scheduledDate;
  }

  static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);

    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  static void cancelNotification(int id) {
    _notification.cancel(id);
  }

  static void cancelAllNotification() {
    _notification.cancelAll();
  }
}