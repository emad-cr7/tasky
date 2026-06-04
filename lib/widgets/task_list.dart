import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/widgets/task_item_widget.dart';

import '../core/widgets/custom_check_box.dart';
import '../modles/taskmodel.dart';

class TaskList extends StatelessWidget {
  TaskList({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
    this.emptyTask,
  });

  List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
  final Function onEdit;

  String? emptyTask;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(
            child: Text(
              emptyTask ?? "",
              style: Theme.of(context).textTheme.displaySmall,
            ),
          )
        : ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tasks.length,
            padding: EdgeInsets.only(bottom: 60),
            itemBuilder: (BuildContext context, int index) {
              return TaskItemWidget(
                model: tasks[index],
                onChanged: (bool? value) {
                  onTap(value, index);
                }, onDelete: (int id) {
                  onDelete(id);
              }, onEdit: onEdit,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 8);
            },
          );
  }
}
