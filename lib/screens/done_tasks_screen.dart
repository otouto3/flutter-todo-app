import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/widget/todo_list.dart';

class DoneTasksScreen extends StatefulWidget {
  @override
  _DoneTasksScreenState createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  Widget builderBottomSheet(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 250, 243, 240),
      backgroundColor: Colors.cyan,

      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Done Task',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${Provider.of<TodoModel>(context).completedTodoList.length} tasks',
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
                  todoList: Provider.of<TodoModel>(context).completedTodoList,
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
