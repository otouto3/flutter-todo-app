import 'package:flutter/material.dart';
import 'package:todoapp/widget/task_tile.dart';
import '../models/todo.dart';
import '../models/todo_model.dart';
import '../screens/edit_task_screen.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todoList;
  final TodoModel todoModel;

  TodoList({this.todoList, this.todoModel});

  @override
  Widget build(BuildContext context) {
    if (todoList.isEmpty) {
      //return Center(child: Text("No Items"));
      return Center(child: Text(""));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        final task = todoList[index];
        return TaskTile(
          taskTitle: task.title,
          taskDate: task.date,
          taskNotificationDate: task.notificationDate,
          isChecked: task.isDone,
          checkboxCallback: (checkBoxState) {
            //taskData.updateTask(task);
            //task.toggleDone();
            todoModel.toggleIsDone(task);
          },
          editButtonCallback: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: EditTaskScreen(task: task),
                ),
              ),
            );
          },
          deleteCallback: () {
            showDialog(
              context: (context),
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('タスクを削除してもいいですか？'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("NO"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                        todoModel.remove(task);
                      },
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      itemCount: todoList.length,
    );
  }
}
