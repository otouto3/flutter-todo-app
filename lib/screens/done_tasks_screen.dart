import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/widget/todo_list.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

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
    int totalStep = todoModel.completedTodoList.length +
        todoModel.incompletedTodoList.length;
    double percentTask = todoModel.completedTodoList.length / totalStep;
    if (totalStep == 0) {
      percentTask = 0;
      totalStep = 1;
    }
    int taskRatio = (percentTask * 100).round();
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'Progress',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            CircularStepProgressIndicator(
              totalSteps: totalStep,
              currentStep: todoModel.completedTodoList.length,
              width: 150,
              height: 150,
              //selectedColor: Color(0xFFA42481),
              selectedColor: Colors.cyanAccent,
            ),
//            CircularPercentIndicator(
//              radius: 180.0,
//              lineWidth: 23.0,
//              animation: true,
//              percent: percentTask,
//              center: Text(
//                "$taskRatio%",
//                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//              ),
////              footer: Text(
////                "Progress",
////                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
////              ),
//              circularStrokeCap: CircularStrokeCap.round,
//              //progressColor: Color(0xFFA42481),
//              progressColor: Color(0xFFC7398E),
//            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
                //width: double.infinity,
                //height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
