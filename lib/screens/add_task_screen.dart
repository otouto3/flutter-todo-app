import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/task_data.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/widget/date_time_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';

class AddTaskScreen extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;
    String newTaskDate;
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
              autofocus: true,
              maxLength: 100,
              textAlign: TextAlign.center,
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            Text(
              'date',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.cyan[300],
              ),
            ),
            BasicDateTimeField(
              onChanged: (newDate) {
                newTaskDate = format.format(newDate);
              },
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
                //時刻が入力されなかった時のエラーを防ぐ
                if (newTaskDate == null) {
                  newTaskDate = "";
                }

                //テキスト未入力のエラーを防ぐ
                if (newTaskTitle == null) {
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
                  Provider.of<TaskData>(context, listen: false)
                      .addTask(newTaskTitle, newTaskDate);
                  Provider.of<TodoModel>(context, listen: false)
                      .add(Todo(title: newTaskTitle, date: newTaskDate));
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
