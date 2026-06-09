import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/add_task/add_task_controller.dart';
import '../../core/widgets/custom_text_from_feild.dart';

class Add_task extends StatelessWidget {
  const Add_task({super.key});


  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (context, _) {
        final controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Form(
                key: controller.key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFromFeild(
                              title: "Task Name",
                              controller: controller.taskNameController,
                              hint: "Finish UI design for login screen",
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please Enter Task Name";
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            SizedBox(height: 8),
                            CustomTextFromFeild(
                              title: "Task Description",
                              controller: controller.taskDescriptionController,
                              maxLines: 5,
                              hint:
                                  "Finish onboarding UI and hand off to devs by Thursday.",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "High Priority ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Consumer<AddTaskController>(
                                  builder:
                                      (
                                        BuildContext context,
                                        AddTaskController value,
                                        Widget? child,
                                      ) {
                                        return Switch(

                                          value: value.isHighPriority,
                                          onChanged: (bool value) {
                                            controller.toggle(value);
                                          },
                                        );
                                      },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),

                      onPressed: () async {
                        context.read<AddTaskController>().addTask(context);
                      },
                      label: Text("Add Task"),
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
