import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
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
        trailing: Checkbox(
          value: false,
        ),
        title: Text(
          'カラオケ',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '2020.4.12 18:00~',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
