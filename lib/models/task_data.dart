import 'package:flutter/foundation.dart';
import 'package:todoapp/models/task.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    Task(name: 'カラオケに行く', date: '2020-04-03 10:21'),
    Task(name: '美味しい物を食べる', date: '2020-05-02 21:19'),
    Task(name: '遊ぶ'),
  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle, String newTaskDate) {
    final task = Task(name: newTaskTitle, date: newTaskDate);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }
}
