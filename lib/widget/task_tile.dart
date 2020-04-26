import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isChecked = false;

  void checkboxCallback(bool checkBoxState) {
    setState(() {
      isChecked = checkBoxState;
    });
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
        trailing: TaskCheckBox(
            checkboxState: isChecked, toggleCheckboxState: checkboxCallback),
        title: Text(
          'カラオケ',
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '2020.4.12 18:00~',
          style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

class TaskCheckBox extends StatelessWidget {
  final bool checkboxState;
  final Function toggleCheckboxState;

  TaskCheckBox({this.checkboxState, this.toggleCheckboxState});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.cyan,
      value: checkboxState,
      onChanged: toggleCheckboxState,
    );
  }
}
