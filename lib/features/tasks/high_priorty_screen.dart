import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/cotrollers/tasks_controller.dart';
import '../../core/components/task_list.dart';



class HighPriortyScreen extends StatelessWidget {
  const HighPriortyScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=> TasksController()..init(),
      builder: (context , _){
        final controller = context.read<TasksController>();
        return Scaffold(
          appBar: AppBar(title: Text("High Priorty Tasks")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<TasksController>(
              builder: (BuildContext context, TasksController controller, Widget? child) {
                return TaskList(
                  emptyTask: "No Tasks",
                  tasks: controller.highPriorityTasks,
                  onTap: (value, index) async {
                    controller.doneHighPriorityTasksTask(value, index);
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
      },
    );
  }
}