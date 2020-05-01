import 'package:flutter/material.dart';
import 'package:todoapp/widget/task_tile.dart';
import 'package:todoapp/models/task.dart';

class TasksList extends StatefulWidget {
  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Task> tasks = [
    Task(name: 'カラオケに行く', date: '2020-04-03 10:21'),
    Task(name: '美味しい物を食べる', date: '2020-05-02 21:19'),
    Task(name: '遊ぶ'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
            taskTitle: tasks[index].name,
            taskDate: tasks[index].date,
            isChecked: tasks[index].isDone,
            checkboxCallback: (checkBoxState) {
              setState(() {
                tasks[index].toggleDone();
              });
            });
      },
      itemCount: tasks.length,
    );
  }
}
