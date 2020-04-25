import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 250, 243, 240),
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              'calender',
            ),
          ],
        ),
      ),
    );
  }
}
