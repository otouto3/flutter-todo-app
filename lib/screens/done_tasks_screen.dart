import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/widget/todo_list.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
    final todoModel = Provider.of<TodoModel>(context);
    double percentTask = todoModel.completedTodoList.length /
        (todoModel.completedTodoList.length +
            todoModel.incompletedTodoList.length);
    if (todoModel.incompletedTodoList.length == 0 &&
        todoModel.completedTodoList.length == 0) {
      percentTask = 0;
    }
    int taskRatio = (percentTask * 100).round();
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            CircularPercentIndicator(
              radius: 200.0,
              lineWidth: 26.0,
              animation: true,
              percent: percentTask,
              center: Text(
                "$taskRatio%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
//              footer:  Text(
//                "Sales this week",
//                style:
//                     TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
//              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.purple,
            ),
            Text(
              'Done Task',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              '${todoModel.completedTodoList.length} tasks',
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
                //Todo #1 DBを引数にするか、TodoList側でDBを定義する(consumerを使う？)
                child: TodoList(
                  todoList: todoModel.completedTodoList,
                  todoModel: todoModel,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
