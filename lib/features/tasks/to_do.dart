import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/servies/preferences_manager.dart';
import '../../modles/taskmodel.dart';
import '../../core/components/sillver_task_list.dart';
import '../../core/components/task_list.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  List<TaskModel> todoTasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final finalTask =  PreferencesManager().getString("tasks");

    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      todoTasks = taskDecode
          .map((element) => TaskModel.fromJSON(element))
          .toList();
      todoTasks = todoTasks
          .where((element) => element.isDone == false)
          .toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  _deletTask(int? id) async {
    List<TaskModel> tasks = [];
    if (id == null) return;
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskDecode.map((element) => TaskModel.fromJSON(element)).toList();
      tasks.removeWhere((e) => e.id == id);
      setState(() {
        todoTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJeson()).toList();
      PreferencesManager().setString('tasks', jsonEncode(updatedTask));
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
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(

          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : CustomScrollView(
                            slivers: [
                 Silver_task_list(
                  emptyTask: "No To Do Tasks",
                  tasks: todoTasks,
                  onTap: (value, index) async {
                    setState(() {
                      todoTasks[index!].isDone = value ?? false;
                    });
                    final allDate = PreferencesManager().getString('tasks');
                    if (allDate != null) {
                      List<TaskModel> allDataList =
                      (jsonDecode(allDate) as List)
                          .map((element) => TaskModel.fromJSON(element))
                          .toList();
                      final newIndex = allDataList.indexWhere(
                            (e) => e.id == todoTasks[index!].id,
                      );
                      allDataList[newIndex] = todoTasks[index!];
                      await PreferencesManager().setString(
                        "tasks",
                        jsonEncode(
                          allDataList.map((e) => e.toJeson()).toList(),
                        ),
                      );
                      _loadTask();
                    }
                  },
                  onDelet: (int? p1) {
                    _deletTask(p1);
                  },
                   onEdit: () {
                     _loadTask();
                   },
                ),
                            ],

                ),
          ),
        ),
      ],
    );
  }
}
