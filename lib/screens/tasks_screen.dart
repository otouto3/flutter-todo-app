import 'package:flutter/material.dart';
import 'package:todoapp/widget/tasks_list.dart';
import 'package:todoapp/screens/add_task_screen.dart';
import 'package:todoapp/models/task.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  List<Task> tasks = [
    Task(name: 'カラオケに行く', date: '2020-04-03 10:21'),
    Task(name: '美味しい物を食べる', date: '2020-05-02 21:19'),
    Task(name: '遊ぶ'),
  ];

  Widget builderBottomSheet(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 250, 243, 240),
      backgroundColor: Colors.cyan,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen((newTaskTitle, newTaskDate) {
                  setState(() {
                    tasks.add(
                      Task(name: newTaskTitle, date: newTaskDate),
                    );
                  });
                  Navigator.pop(context);
                }),
              ),
            ),
          );
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 40.0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Todo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${tasks.length} tasks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                //width: double.infinity,
                //height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                //child:
                child: TasksList(
                  tasks: tasks,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
