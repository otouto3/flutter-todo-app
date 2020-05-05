import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_task_screen.dart';
import 'package:provider/provider.dart';

import '../models/todo_model.dart';
import '../widget/todo_list.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  Widget builderBottomSheet(BuildContext context) {
    return Container();
  }

  String taskNumText() {
    int num = Provider.of<TodoModel>(context).incompletedTodoList.length;
    if (num == 0) {
      return "No task";
    } else if (num == 1) {
      return "1 task";
    } else {
      return "$num tasks";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: AddTaskScreen(),
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
              taskNumText(),
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
                child: TodoList(
                  todoList: Provider.of<TodoModel>(context).incompletedTodoList,
                  todoModel: Provider.of<TodoModel>(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
