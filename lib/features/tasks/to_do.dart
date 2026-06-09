import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/cotrollers/tasks_controller.dart';
import '../../core/components/task_list.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
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
                  emptyTask: "No To Do Tasks",
                  tasks: controller.todoTasks,
                  onTap: (value, index) async {
                    controller.doneTasks(value, controller.todoTasks[index!].id,);
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