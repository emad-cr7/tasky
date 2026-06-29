import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/core/widgets/animation/custom_animation4.dart';

import '../../models/task_model.dart';

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
            child: CustomAnimation4(child:Text(
              emptyTask ?? "",
              style: Theme.of(context).textTheme.displaySmall,
            ), )
          )


        : SingleChildScrollView(
            child: AnimationLimiter(
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: tasks.length,
                padding: EdgeInsets.only(bottom: 60),
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: Duration(milliseconds: 500),
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: TaskItemWidget(
                          model: tasks[index],
                          onChanged: (bool? value) {
                            onTap(value, index);
                          },
                          onDelete: (int id) {
                            onDelete(id);
                          },
                          onEdit: onEdit,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8);
                },
              ),
            ),
          );
  }
}
