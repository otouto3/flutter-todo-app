import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo_model.dart';
import 'screens/tasks_screen.dart';
import 'screens/calender_screen.dart';
import 'screens/done_tasks_screen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/todo_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

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

/// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
/// Please download the complete example app from the GitHub repository where all the setup has been done
Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    selectNotificationSubject.add(payload);
  });

//  runApp(
//    MaterialApp(
//      home: MyApp(),
//    ),
//  );
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

//void main() {
//  initializeDateFormatting().then((_) => runApp(MyApp()));
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        //primaryColor: Colors.cyan,
        //accentColor: Colors.cyan,
        //canvasColor: Colors.white,
      ),
      home: ChangeNotifierProvider(
        create: (context) => TodoModel(),
        child: MaterialApp(
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class PaddedRaisedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const PaddedRaisedButton({
    @required this.buttonText,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
      child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// SingleTickerProviderStateMixinを使用。後述
class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final MethodChannel platform =
      MethodChannel('crossingthestreams.io/resourceResolver');
  @override
  void initState() {
    super.initState();
    _requestIOSPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    // コントローラ作成
    _pageController = PageController(
      initialPage: _screen, // 初期ページの指定。上記で_screenを１とすれば２番目のページが初期表示される。
    );
  }

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
                    builder: (context) =>
                        TasksScreen(payload: receivedNotification.payload),
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
        MaterialPageRoute(builder: (context) => TasksScreen(payload: payload)),
      );
    });
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    _pageController.dispose();
    super.dispose();
  }

  // ページ切り替え用のコントローラを定義
  PageController _pageController;

  // ページインデックス保存用
  int _screen = 0;

  // ページ下部に並べるナビゲーションメニューの一覧
  List<BottomNavigationBarItem> myBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.check_box_outline_blank,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.check_box,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text('check box'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.date_range,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text('Home'),
      ),
    ];
  }

//  @override
//  void initStateContro() {
//    super.initState();
//    // コントローラ作成
//    _pageController = PageController(
//      initialPage: _screen, // 初期ページの指定。上記で_screenを１とすれば２番目のページが初期表示される。
//    );
//  }

//  @override
//  void disposeController() {
//    // コントローラ破棄
//    _pageController.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ページビュー
      body: PageView(
        controller: _pageController,
        // ページ切り替え時に実行する処理
        // PageViewのonPageChangedはページインデックスを受け取る
        // 以下ではページインデックスをindexとする
        onPageChanged: (index) {
          setState(() {
            // ページインデックスを更新
            _screen = index;
          });
        },
        // ページ下部のナビゲーションメニューに相当する各ページビュー。後述
        children: [
          TasksScreen(),
          DoneTasksScreen(),
          CalendarScreen(),
        ],
      ),
      // ページ下部のナビゲーションメニュー
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // 現在のページインデックス
        currentIndex: _screen,
        // onTapでナビゲーションメニューがタップされた時の処理を定義
        onTap: (index) {
          setState(() {
            // ページインデックスを更新
            _screen = index;

            // ページ遷移を定義。
            // curveで指定できるのは以下
            // https://api.flutter.dev/flutter/animation/Curves-class.html
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.easeOut);
          });
        },
        // 定義済のナビゲーションメニューのアイテムリスト
        items: myBottomNavBarItems(),
      ),
    );
  }
}
