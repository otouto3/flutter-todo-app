import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final String taskDate;
  final Function checkboxCallback;
  final Function longPressCallback;
  final Function deleteCallback;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.taskDate,
      this.checkboxCallback,
      this.longPressCallback,
      this.deleteCallback});

  String showDate(String taskDate) {
    if (taskDate == "") {
      return taskDate;
    } else {
      DateTime date = DateTime.parse(taskDate);
      String month = date.month.toString();
      String day = date.day.toString();
      String hour = date.hour.toString();
      String minute = date.minute.toString();
      return month + "/" + day + " " + hour + ":" + minute;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.5, horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        //leading: Icon(Icons.accessibility),
        leading: Checkbox(
          activeColor: Colors.cyan,
          value: isChecked,
          onChanged: checkboxCallback,
        ),
        trailing: Wrap(
          //mainAxisSize: MainAxisSize.min,
          spacing: 0,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteCallback,
            ),
          ],
        ),
//        trailing: Row(
//          //spacing: -60,
//          mainAxisSize: MainAxisSize.min,
//          children: <Widget>[
//            ButtonTheme(
//              minWidth: 3.0,
//              child: FlatButton(
//                child: Icon(Icons.edit),
//                onPressed: () {},
//              ),
//            ),
//            ButtonTheme(
//              minWidth: 3,
//              child: FlatButton(
//                child: Icon(Icons.delete),
//                onPressed: deleteCallback,
//              ),
//            ),
//          ],
//        ),
        onLongPress: longPressCallback,
        title: Text(
          taskTitle,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          showDate(taskDate),
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
