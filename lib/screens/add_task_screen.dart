import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'dart:async';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todoapp/screens/tasks_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails;

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  final titleTextEditingController = TextEditingController();
  final dateTextEditingController = TextEditingController();
  final reminderTextEditingController = TextEditingController();

  bool _switchValue = false;

//  @override
//  void initState() {
//    print("init");
//    super.initState();
//    //setupNotificationPlugin();
//    setupNotificationPlugin();
//    _requestIOSPermissions();
//    _configureDidReceiveLocalNotificationSubject();
//    _configureSelectNotificationSubject();
//  }

  void _requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TasksScreen(),
                  ),
                );
              },
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TasksScreen()),
      );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
                color: Colors.cyan,
              ),
            ),
            Text(
              'name',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.cyan[300],
              ),
            ),
            TextField(
              controller: titleTextEditingController,
              autofocus: true,
              maxLength: 100,
              textAlign: TextAlign.center,
            ),
            Text(
              'date',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.cyan[300],
              ),
            ),
            DateTimeField(
              format: format,
              controller: dateTextEditingController,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),
            SwitchListTile(
                value: _switchValue,
                activeColor: Colors.cyan,
                activeTrackColor: Colors.cyan,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                secondary: Icon(
                  Icons.notifications,
                  color: _switchValue ? Colors.cyan : Colors.grey[500],
                  size: 40.0,
                ),
                title: Text('Reminder'),
                //subtitle: Text('サブタイトル'),
                onChanged: (bool value) {
                  setState(() {
                    setupNotificationPlugin();
                    _requestIOSPermissions();
                    _configureDidReceiveLocalNotificationSubject();
                    _configureSelectNotificationSubject();
                    _switchValue = value;
                  });
                }),
            Visibility(
              visible: _switchValue,
              child: Text(
                'Reminder',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.cyan[300],
                ),
              ),
            ),
            Visibility(
              visible: _switchValue,
              child: DateTimeField(
                format: format,
                controller: reminderTextEditingController,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              color: Colors.cyan,
              onPressed: () {
                //テキスト未入力のエラーを防ぐ
                if (titleTextEditingController.text == "") {
                  showDialog(
                    context: (context),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('タスク名を入力してください。'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK"),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      );
                    },
                  );
                } else {
//                  print(titleTextEditingController.text);
//                  print(dateTextEditingController.text);

                  // reminderTextが空白じゃない（時刻入力がされている）かつreminderのスイッチが押されている
                  if (reminderTextEditingController.text != "" &&
                      _switchValue == true) {
                    setupNotification(
                        titleTextEditingController.text,
                        dateTextEditingController.text,
                        reminderTextEditingController.text);
                    getNotification();
                  } else {
                    Provider.of<TodoModel>(context, listen: false).add(Todo(
                        title: titleTextEditingController.text,
                        date: dateTextEditingController.text,
                        notificationDate: reminderTextEditingController.text));
                  }
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void getNotification() async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (int i = 0; i < pendingNotificationRequests.length; i++) {
      print(" id は ${pendingNotificationRequests[i].id}");
      print(pendingNotificationRequests[i].title);
    }
    //await flutterLocalNotificationsPlugin.cancel(10);
  }

  void setupNotificationPlugin() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid,
      initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
//        .then((init) {
//      setupNotification2();
//    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => TasksScreen()),
    );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("Don't forget to add your expenses"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  void setupNotification(String title, String date, String reminderDate) async {
    DateTime taskDate = DateTime.parse(reminderDate);
    DateTime dateFrom = DateTime(taskDate.year, taskDate.month, taskDate.day,
        taskDate.hour, taskDate.minute, taskDate.second);
    DateTime today = DateTime.now();
    DateTime dateTo = DateTime(today.year, today.month, today.day, today.hour,
        today.minute, today.second);

    int interval = (dateFrom.difference(dateTo)).inSeconds;
    print(interval);

    int notificationId = 0;
    int taskLatestId;

    // DBからタスクを取得できなかったらnotification id=0としてnotificationする
    // DBにタスクを追加→取得の順番のはずなので，本来ならこの処理はいらない
    List taskList = Provider.of<TodoModel>(context, listen: false).allTodoList;
    if (taskList.length != 0) {
      Todo task = taskList.last;
      taskLatestId = task.id;
      notificationId = 1 + taskLatestId;
    }

    Provider.of<TodoModel>(context, listen: false).add(Todo(
        title: titleTextEditingController.text,
        date: dateTextEditingController.text,
        notificationId: notificationId,
        notificationDate: reminderTextEditingController.text));

    var scheduledNotificationDateTime =
        DateTime.now().add(Duration(seconds: interval));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'daily-notifications', 'Daily Notifications', 'Daily Notifications');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        notificationId,
        title,
        "$title + の時間です",
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }
}
