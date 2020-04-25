import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 250, 243, 240),
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Column(
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.date_range,
              size: 30.0,
              color: Colors.black,
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              child: Icon(
                Icons.add,
                size: 30.0,
                color: Colors.white,
              ),
              backgroundColor: Colors.cyan,
              radius: 20.0,
            ),
            title: Text('add task'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box,
              size: 30.0,
              color: Colors.black,
            ),
            title: Text('check box'),
          ),
        ],
        //  currentIndex: _selectedIndex,
        //  selectedItemColor: Colors.amber[800],
        //  onTap: _onItemTapped,
      ),
    );
  }
}
