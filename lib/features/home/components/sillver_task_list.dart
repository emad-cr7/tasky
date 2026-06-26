import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/core/widgets/animation/custom_animation4.dart';


import '../../../core/widgets/animation/custom_animation.dart';
import '../../tasks/cotrollers/tasks_controller.dart';

class Silver_task_list extends StatelessWidget {
  Silver_task_list({super.key, this.emptyTask});

  final String? emptyTask;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            final tasksList = controller.tasks;
            return tasksList.isEmpty
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
                      itemCount: tasksList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomAnimation(
                          child: TaskItemWidget(
                            model: tasksList[index],
                            onChanged: (bool? value) {
                              controller.doneTasks(value, tasksList[index].id);
                            },
                            onDelete: (int id) {
                              controller.deletTask(id);
                            },
                            onEdit: () => controller.loadTask(),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  );
          },
    );
  }
}
