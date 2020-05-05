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
        trailing: FlatButton(
          child: Icon(Icons.delete),
          onPressed: deleteCallback,
        ),
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
          taskDate,
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
