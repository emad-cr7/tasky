import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';
import '../../modles/taskmodel.dart';
import '../../core/components/sillver_task_list.dart';
import '../../core/components/task_list.dart';

class ToDoCompleted extends StatefulWidget {
  const ToDoCompleted({super.key});

  @override
  State<ToDoCompleted> createState() => _ToDoCompletedState();
}

class _ToDoCompletedState extends State<ToDoCompleted> {
  List<TaskModel> completedTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      completedTasks = taskDecode
          .map((element) => TaskModel.fromJSON(element))
          .toList();
      completedTasks = completedTasks
          .where((element) => element.isDone == true)
          .toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  _deletTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;

    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskDecode.map((element) => TaskModel.fromJSON(element)).toList();
      tasks.removeWhere((e) => e.id == id);
      setState(() {
        completedTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJeson()).toList();
      PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : TaskList(
                    emptyTask: "No Completed Tasks",
                    tasks: completedTasks,
                    onTap: (value, index) async {
                      setState(() {
                        completedTasks[index!].isDone = value ?? false;
                      });
                      final allDate = PreferencesManager().getString(StorageKey.tasks);

                      if (allDate != null) {
                        List<TaskModel> allDataList =
                            (jsonDecode(allDate) as List)
                                .map((element) => TaskModel.fromJSON(element))
                                .toList();
                        final newIndex = allDataList.indexWhere(
                          (e) => e.id == completedTasks[index!].id,
                        );
                        allDataList[newIndex] = completedTasks[index!];
                        await PreferencesManager().setString(
                          StorageKey.tasks,
                          jsonEncode(
                            allDataList.map((e) => e.toJeson()).toList(),
                          ),
                        );
                        _loadTask();
                      }
                    },
                    onDelete: (int? id) {
                      _deletTask(id);
                    },

                    onEdit: () {
                      _loadTask();
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
