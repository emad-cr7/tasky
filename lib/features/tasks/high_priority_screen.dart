import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/cotrollers/tasks_controller.dart';
import '../../core/components/task_list.dart';
import '../../core/constants/app_sizes.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(title: Text("High Priorty Tasks")),
      body: Padding(
        padding:  EdgeInsets.all(AppSizes.pw16),
        child: Consumer<TasksController>(
          builder:
              (
                BuildContext context,
                TasksController controller,
                Widget? child,
              ) {
                return TaskList(
                  emptyTask: "No Tasks",
                  tasks: controller.highPriorityTasks,
                  onTap: (value, index) async {
                    controller.doneTasks(value, controller.highPriorityTasks[index!].id,
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
    );
  }
}
