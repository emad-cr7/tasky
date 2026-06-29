import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_text_from_feild.dart';
import '../../models/task_model.dart';
import '../constants/storage_key.dart';
import '../enums/task_item_action.dart';
import '../servies/preferences_manager.dart';
import '../widgets/custom_check_box.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskModel model;
  final Function(bool? value) onChanged;
  final Function(int) onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: AppSizes.h56 ,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(AppSizes.r20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: AppSizes.w8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),

          SizedBox(width: AppSizes.w16),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    maxLines: 1,
                    model.taskName,
                    style: model.isDone
                        ? Theme.of(context).textTheme.titleLarge
                        : Theme.of(context).textTheme.titleMedium,
                  ),
                  if (model.description.isNotEmpty)
                    Text(
                      maxLines: 1,
                      model.description,
                      style: TextStyle(
                        color: Color(0xffC6C6C6),
                        fontSize: AppSizes.sp14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
          ),
          PopupMenuButton<TaskItemAction>(
            icon: Icon(
              Icons.more_vert,
              color: ThemeController.isDark()
                  ? (model.isDone ? Color(0xffA0A0A0) : Color(0xffFFFCFC))
                  : (model.isDone ? Color(0xff6A6A6A) : Color(0xff3A4640)),
            ),

            itemBuilder: (context) => TaskItemAction.values.map((e) {
              return PopupMenuItem<TaskItemAction>(
                value: e,
                child: Text(e.name , style: Theme.of(context).textTheme.labelSmall,),
              );
            }).toList(),

            onSelected: (value) async {
              switch (value) {
                case TaskItemAction.markAsDone:
                  onChanged(!model.isDone);

                case TaskItemAction.edit:
                  final result = await _showButtonSheet(context, model);
                  if (result == true) {
                    onEdit();
                  }

                case TaskItemAction.delete:
                  await _showAlertDialog(context);
              }
            },
          ),
        ],
      ),
    );
  }

  _showAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text(
            "Are you sure want to delete this task",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                onDelete(model.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showButtonSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController = TextEditingController(
      text: model.taskName,
    );

    TextEditingController taskDescriptionController = TextEditingController(
      text: model.description,
    );

    GlobalKey<FormState> _key = GlobalKey<FormState>();

    bool isHighPriority = model.isHighPriority;

    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal:AppSizes.pw16, vertical:AppSizes.ph8),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      thickness: 5,
                      indent: 150,
                      endIndent: 150,
                      radius: BorderRadius.circular(AppSizes.r50),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height:AppSizes.ph30),
                            CustomTextFromField(
                              title: "Task Name",
                              controller: taskNameController,
                              hint: "Finish UI design for login screen",
                              validator: (String? value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please Enter Task Name";
                                }
                              },
                            ),
                            SizedBox(height: AppSizes.ph20),
                            CustomTextFromField(
                              title: "Task Description",
                              controller: taskDescriptionController,
                              maxLines: 5,
                              hint:
                              "Finish onboarding UI and hand off to devs by Thursday.",
                            ),
                            SizedBox(height: AppSizes.ph20),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "High Priority ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
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

                    Spacer(),

                    ElevatedButton.icon(
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          final taskJson = await PreferencesManager().getString(
                            StorageKey.tasks,
                          );

                          List<dynamic> listTasks = [];
                          if (taskJson != null) {
                            listTasks = jsonDecode(taskJson);
                          }

                          TaskModel newModel = TaskModel(
                            id: model.id,
                            taskName: taskNameController.text,
                            description: taskDescriptionController.text,
                            isHighPriority: isHighPriority,
                            isDone: model.isDone,
                          );

                          final item = listTasks.firstWhere(
                                (e) => e['id'] == model.id,
                          );

                          final int index = listTasks.indexOf(item);

                          listTasks[index] = newModel.toJson();

                          final taskEncode = jsonEncode(listTasks);

                          await PreferencesManager().setString(
                            "tasks",
                            taskEncode,
                          );

                          Navigator.of(context).pop(true);
                        }
                      },
                      label: Text("Edit Task"),
                      icon: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}