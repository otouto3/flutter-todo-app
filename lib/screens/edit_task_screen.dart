import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/models/todo.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditTaskScreen extends StatefulWidget {
  final Todo task;
  EditTaskScreen({this.task});
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final titleTextEditingController = TextEditingController(text: task.title);
    final dateTextEditingController = TextEditingController(text: task.date);
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
              'Edit Task',
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
                'Save',
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
                  Provider.of<TodoModel>(context, listen: false).update(
                    //updateの時はidを指定しないといけない
                    Todo(
                        id: task.id,
                        title: titleTextEditingController.text,
                        date: dateTextEditingController.text),
                  );
//                  List list = (Provider.of<TodoModel>(context, listen: false)
//                      .incompletedTodoList);
//                  for (int i = 0; i < list.length; i++) {
//                    Todo task = list[i];
//                    print(task.id);
//                    print(task.title);
//                    print(task.date);
//                  }
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
