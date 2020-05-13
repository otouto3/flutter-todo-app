import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final String taskDate;
  final String taskNotificationDate;
  final Function checkboxCallback;
  final Function editButtonCallback;
  final Function deleteCallback;

  TaskTile(
      {this.isChecked,
      this.taskTitle,
      this.taskDate,
      this.taskNotificationDate,
      this.checkboxCallback,
      this.editButtonCallback,
      this.deleteCallback});

  String formatDate(String taskDate) {
    if (taskDate == "") {
      return taskDate;
    } else {
      DateTime date = DateTime.parse(taskDate);
      String month = date.month.toString();
      String day = date.day.toString();
      String hour = date.hour.toString();
      // 13時04分だったら 13:4と表示せずに13:04とするようにした
      String minute = date.minute > 9
          ? date.minute.toString()
          : '0' + date.minute.toString();
      return month + "/" + day + " " + hour + ":" + minute;
    }
  }

  String showDate(String taskDate, String taskNotificationDate) {
    if (taskNotificationDate == "") {
      return formatDate(taskDate);
    } else if (taskDate == "") {
      return formatDate(taskNotificationDate);
    } else {
      return formatDate(taskDate) + "\n" + formatDate(taskNotificationDate);
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
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: editButtonCallback,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: deleteCallback,
            ),
          ],
        ),
        isThreeLine: true,
        dense: true,
        title: Text(
          taskTitle,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                showDate(taskDate, taskNotificationDate),
                style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null,
                  fontSize: 20.0,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Visibility(
                  visible: taskDate != "" ? true : false,
                  child: Icon(
                    Icons.event_note,
                  ),
                ),
                Visibility(
                  visible: taskNotificationDate != "" ? true : false,
                  child: Icon(
                    Icons.notifications,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
