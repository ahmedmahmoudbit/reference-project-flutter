import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reference_project_flutter/core/constants.dart';
import 'package:reference_project_flutter/core/cubit/state.dart';
import 'package:reference_project_flutter/core/di/injection.dart';
import 'package:reference_project_flutter/core/network/local/cache_helper.dart';
import 'package:reference_project_flutter/core/network/repository.dart';
import 'package:reference_project_flutter/features/todo/data/create_db.dart';
import 'package:reference_project_flutter/features/todo/data/model.dart';
import 'package:reference_project_flutter/features/todo/ui/home/ShoNotificationData.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MainBloc extends Cubit<MainState> {
  final Repository repository;

  MainBloc({
    required Repository repository,
  })  : repository = repository,
        super(Empty());

  static MainBloc get(context) => BlocProvider.of(context);

  /// variables bool
  bool isRtl = false;
  bool isDark = false;

  /// variables int
  int? currentPage;

  /// dark colors
  String scaffoldBackground = '11202a';
  String mainColorDark = 'ffffff';
  String mainColorVariantDark = '8a8a89';

  /// dark colors
  String secondaryDark = 'ffffff';
  String secondaryVariantDark = '8a8a89';

  late ThemeData lightTheme;
  late ThemeData darkTheme;

  /// start sqlFlit ---------------------------------------

  // start notification_custom ---------------------------------------

  var taskList = <TaskModel>[];

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  void initalizeNotification(BuildContext context) async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    _configureLocalTimezone();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin!.initialize(
      initializationSettings,
        onSelectNotification: (payload) => selectNotification('${taskList[0].title}|${taskList[0].note}|',context),
    );
  }

  displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
      0,
      'You change your theme',
      'You changed your theme back !',
      platformChannelSpecifics,
      payload: 'It could be anything you pass',
    );
  }

  scheduledNotification(int hour , int minutes , TaskModel task) async {
    await flutterLocalNotificationsPlugin!.zonedSchedule(
        task.id!.toInt(),
        task.title,
        task.note,
        _convertTime(hour,minutes),
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id',
                'your channel name')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${task.title}|${task.note}|"
    );
  }

  tz.TZDateTime _convertTime(int hour,int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local,now.year,now.month,now.day,hour,minutes);
    if(scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void selectNotification(String? payload,BuildContext context) async {
    if (payload != null) {
      print('notification_custom payload: $payload');
    } else {
      print("Notification Done");
    }
    print("notificationn ..");
    Container(color: Colors.redAccent);
    navigateTo(context, ShoNotificationData(text: payload!));
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    // display a dialog with the notification_custom details, tap ok to go to another page
    print('Hi');
  }

  // end notification_custom ---------------------------------------

  // start sqlFlit ---------------------------------------

  void addTask({required TaskModel task}) async {
    await DBHelper.insert(task).then((value) {
      getTask();
    });
  }

  void getTask() async {
    taskList = [];
    await DBHelper.query().then((value) {
      taskList.addAll(value.map((data) => TaskModel.fromJson(data)).toList());
      emit(GetTask());
    });
  }

  void delete({required TaskModel task}) async {
    await DBHelper.delete(task).then((value) {
      getTask();
    });
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id).then((value) {
      getTask();
    });
  }

  // end sqlFlit ---------------------------------------

  /// end sqlFlit ---------------------------------------

  void changeDarkMode() {
    isDark = !isDark;
    sl<CacheHelper>().put('isDark', isDark);
    setThemes(change: isDark);
    emit(ChangeDarkMode());
  }

  void setThemes({required bool change}) {
    isDark = change;
    isDarkMode = isDark;
    changeTheme();
    emit(ThemeLoaded());
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  static String defaultFontFamily = 'Avenir';
  static const Color primaryTextColor = Color(0xFF0D253C);
  static const Color secondaryTextColor = Color(0xFF2D4379);
  static const Color primaryColor = Color(0xff376AED);

  void changeTheme() {
    lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: primaryTextColor,
        titleSpacing: 32,
        elevation: 0,
      ),
      colorScheme: const ColorScheme.light(
          primary: primaryColor,
          surface: Colors.white,
          onSurface: primaryTextColor,
          onSecondary: secondaryTextColor,
          onPrimary: Colors.white,
          background: Color(0xfffbfcff),
          onBackground: Colors.black),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            TextStyle(
                fontSize: 14,
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
          backgroundColor: primaryColor,
          contentTextStyle: TextStyle(color: Colors.white)),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: primaryTextColor,
        ),
        headlineSmall: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: primaryTextColor),
        headlineMedium: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w700,
            color: primaryTextColor,
            fontSize: 24),
        titleMedium: TextStyle(
          fontFamily: defaultFontFamily,
          color: secondaryTextColor,
          fontWeight: FontWeight.w200,
          fontSize: 18,
        ),
        titleSmall: TextStyle(
          fontFamily: defaultFontFamily,
          color: primaryTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        bodyLarge: TextStyle(
          fontFamily: defaultFontFamily,
          fontWeight: FontWeight.w400,
          color: primaryTextColor,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          fontFamily: defaultFontFamily,
          color: secondaryTextColor,
          fontSize: 12,
        ),
        bodySmall: TextStyle(
            fontFamily: defaultFontFamily,
            color: const Color(0xff7B8BB2),
            fontSize: 10,
            fontWeight: FontWeight.w800),
      ),
    );

    darkTheme = ThemeData(
      primaryColor: Colors.yellow,
      primaryColorLight: Colors.yellow,
      primaryColorDark: Colors.yellow,
      // background
      scaffoldBackgroundColor: Colors.black38,
      // canvasColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: Platform.isIOS
            ? null
            : const SystemUiOverlayStyle(
                statusBarColor: Color(0x00060a0c),
                statusBarIconBrightness: Brightness.light,
              ),
        backgroundColor: darkGreyClr,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(
          size: 20.0,
          color: HexColor(mainColorDark),
        ),
        titleTextStyle: TextStyle(
          color: HexColor(grey),
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: HexColor(scaffoldBackground),
        elevation: 50.0,
        selectedItemColor: HexColor(mainColor),
        unselectedItemColor: HexColor(grey),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      // any selected item .
      primarySwatch: MaterialColor(int.parse('0xff$mainColorD'), color),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: HexColor(surface),
          height: 1.3,
        ),
        bodyText1: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        bodyText2: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.w700,
          color: HexColor(surface),
          height: 1.4,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: HexColor(surface),
          height: 1.4,
        ),
        subtitle2: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        caption: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: HexColor(surface),
          height: 1.4,
        ),
        button: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.4,
        ),
      ),
    );
  }

  void changeMode({required bool value}) {
    isDark = value;
    sl<CacheHelper>().put('isDark', isDark);
    emit(ChangeModeState());
  }
}
