import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  final titleTextEditingController = TextEditingController();
  final dateTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              controller: titleTextEditingController,
              autofocus: true,
              maxLength: 100,
              textAlign: TextAlign.center,
            ),
            Text(
              'date',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.cyan[300],
              ),
            ),
            DateTimeField(
              format: format,
              controller: dateTextEditingController,
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
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
                //テキスト未入力のエラーを防ぐ
                if (titleTextEditingController.text == "") {
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
                  print(titleTextEditingController.text);
                  print(dateTextEditingController.text);
                  Provider.of<TodoModel>(context, listen: false).add(Todo(
                      title: titleTextEditingController.text,
                      date: dateTextEditingController.text));
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
