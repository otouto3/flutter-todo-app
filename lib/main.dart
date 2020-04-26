import 'package:flutter/material.dart';
import 'screens/tasks_screen.dart';
import 'screens/calender_screen.dart';
import 'screens/done_tasks_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

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
      home: MyHomePage(),
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
  // ページ切り替え用のコントローラを定義
  PageController _pageController;

  // ページインデックス保存用
  int _screen = 0;

  // ページ下部に並べるナビゲーションメニューの一覧
  List<BottomNavigationBarItem> myBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.date_range,
          size: 30.0,
          color: Colors.black,
        ),
        title: Text('Home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.library_add,
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
    ];
  }

  @override
  void initState() {
    super.initState();
    // コントローラ作成
    _pageController = PageController(
      initialPage: _screen, // 初期ページの指定。上記で_screenを１とすれば２番目のページが初期表示される。
    );
  }

  @override
  void dispose() {
    // コントローラ破棄
    _pageController.dispose();
    super.dispose();
  }

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
          CalendarScreen(),
          TasksScreen(),
          DoneTasksScreen(),
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
