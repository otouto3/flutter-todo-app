//import 'package:flutter/material.dart';
//import 'package:todoapp/widget/task_tile.dart';
//import 'package:provider/provider.dart';
//import 'package:todoapp/models/task_data.dart';
//
//class TasksList extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Consumer<TaskData>(
//      builder: (context, taskData, child) {
//        return ListView.builder(
//          itemBuilder: (context, index) {
//            final task = taskData.tasks[index];
//            return TaskTile(
//              taskTitle: task.name,
//              taskDate: task.date,
//              isChecked: task.isDone,
//              checkboxCallback: (checkBoxState) {
//                taskData.updateTask(task);
//              },
//              longPressCallback: () {
//                taskData.deleteTask(task);
//              },
//            );
//          },
//          itemCount: taskData.taskCount,
//        );
//      },
//    );
//  }
//}
