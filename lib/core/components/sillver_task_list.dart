import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import '../widgets/custom_check_box.dart';
import '../../modles/taskmodel.dart';

class Silver_task_list extends StatelessWidget {
  Silver_task_list({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelet,
    required this.onEdit,
    this.emptyTask,
  });

  List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelet;
  final Function onEdit;

  final String? emptyTask;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                emptyTask ?? "",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsetsGeometry.only(bottom: 55),
            sliver: SliverList.separated(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDelete: (int id) {
                    onDelet(id);
                  }, onEdit: onEdit,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
            ),
          );
  }
}
