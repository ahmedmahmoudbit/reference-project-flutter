import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:reference_project_flutter/features/notification_custom/notification.dart';
import 'package:reference_project_flutter/features/notification_custom/page/receiverNotification.dart';
import 'package:timezone/data/latest.dart' as tz;


class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {


  @override
  void initState() {
    super.initState();
    // Initialization notification_custom plugin
    NotificationApi.init(initSchedule: true);
    // listen notification_custom is click ? if yes navigate to test page and send data
    listenNotification();
    // Initialization Tz .
    tz.initializeTimeZones();
  }

  void listenNotification() => NotificationApi.onNotifications.stream
      .listen((event) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReceiverNotification(text: event!))));

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () => NotificationApi.showNotification(
                    title: 'AM', body: 'geecoders is here !', payload: 'GeeCoders'),
                child: const Text(
                  'Go to showNotification',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.blueAccent,
                onPressed: () {
                  NotificationApi.showScheduleNotification(
                    title: 'AM',
                    body: 'send notification_custom after 5 seconds',
                    payload: 'GeeCoders',
                    dateTime: DateTime.now().add(const Duration(seconds: 5)),
                  );
                  debugPrint(DateTime.now().toString());
                  debugPrint(DateTime.now().day.toString());
                },
                child: const Text(
                  'Go to showScheduleNotification',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}

