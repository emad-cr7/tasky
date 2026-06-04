import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/modles/taskmodel.dart';

import '../core/servies/preferences_manager.dart';
import '../core/widgets/custom_text_from_feild.dart';

class Add_task extends StatefulWidget {
  const Add_task({super.key});

  @override
  State<Add_task> createState() => _Add_taskState();
}

class _Add_taskState extends State<Add_task> {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();

  bool isHighPriority = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _key,
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
                          controller: taskNameController,
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
                          controller: taskDescriptionController,
                          maxLines: 5,
                          hint: "Finish onboarding UI and hand off to devs by Thursday.",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "High Priority ",
                              style: Theme.of(context).textTheme.titleMedium),
                            Switch(
                              value: isHighPriority,
                              onChanged: (bool value) {
                                setState(() {
                                  isHighPriority = value;
                                });
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
                    if (_key.currentState?.validate() ?? false) {
                      final taskJson = await PreferencesManager().getString("tasks");

                      List<dynamic> listTasks = [];
                      if (taskJson != null) {
                        listTasks = jsonDecode(taskJson);
                      }

                      TaskModel model = TaskModel(
                        id: listTasks.length + 1,
                        taskName: taskNameController.text,
                        description: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                      );

                      listTasks.add(model.toJeson());

                      final taskEncode = jsonEncode(listTasks);
                      await PreferencesManager().setString("tasks", taskEncode);

                      Navigator.of(context).pop(true);
                    }
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
  }
}
