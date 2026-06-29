import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/cotrollers/tasks_controller.dart';
import '../../core/components/task_list.dart';
import '../../core/constants/app_sizes.dart';

class ToDoCompleted extends StatelessWidget {
  const ToDoCompleted({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.all(AppSizes.pw16),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding:  EdgeInsets.all(AppSizes.pw16),
            child: controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Consumer<TasksController>(
                    builder:
                        (
                          BuildContext context,
                          TasksController controller,
                          Widget? child,
                        ) {
                          return TaskList(
                            emptyTask: "No Completed Tasks",
                            tasks: controller.completed,
                            onTap: (value, index) async {
                              controller.doneTasks(
                                value,
                                controller.completed[index!].id,
                              );
                            },
                            onDelete: (int? id) {
                              controller.deletTask(id);
                            },
                            onEdit: () {
                              controller.init();
                            },
                          );
                        },
                  ),
          ),
        ),
      ],
    );
  }
}
