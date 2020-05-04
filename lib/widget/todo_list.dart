import 'package:flutter/material.dart';
import 'package:todoapp/widget/task_tile.dart';
import '../models/todo.dart';
import '../models/todo_model.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todoList;
  final TodoModel todoModel;

  TodoList({this.todoList, this.todoModel});

  @override
  Widget build(BuildContext context) {
    if (todoList.isEmpty) {
      return Center(child: Text("No Items"));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        final task = todoList[index];
        return TaskTile(
          taskTitle: task.title,
          taskDate: task.date,
          isChecked: task.isDone,
          checkboxCallback: (checkBoxState) {
            //taskData.updateTask(task);
            //task.toggleDone();
            todoModel.toggleIsDone(task);
          },
          longPressCallback: () {
            //taskData.deleteTask(task);
          },
          deleteCallback: () {
            todoModel.remove(task);
          },
        );
      },
      itemCount: todoList.length,
    );
  }
}
