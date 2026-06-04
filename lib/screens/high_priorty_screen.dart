import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/servies/preferences_manager.dart';
import '../modles/taskmodel.dart';
import '../widgets/sillver_task_list.dart';
import '../widgets/task_list.dart';

class HighPriortyScreen extends StatefulWidget {
  const HighPriortyScreen({super.key});

  @override
  State<HighPriortyScreen> createState() => _HighPriortyScreenState();
}

class _HighPriortyScreenState extends State<HighPriortyScreen> {
  List<TaskModel> highpriortyTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;

      highpriortyTasks = taskDecode
          .map((element) => TaskModel.fromJSON(element))
          .toList();
      highpriortyTasks = highpriortyTasks
          .where((element) => element.isHighPriority == true)
          .toList()
          .reversed
          .toList();
    }
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        highpriortyTasks = taskDecode
            .map((element) => TaskModel.fromJSON(element))
            .toList();
        highpriortyTasks = highpriortyTasks
            .where((element) => element.isHighPriority == true)
            .toList()
            .reversed
            .toList();
      });
    }
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
        highpriortyTasks.removeWhere((task) => task.id == id);
      });
      final updatedTask = tasks.map((element) => element.toJeson()).toList();
      PreferencesManager().setString('tasks', jsonEncode(updatedTask));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("High Priorty Tasks")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            Silver_task_list(
              emptyTask: "No Tasks",
              tasks: highpriortyTasks,
              onTap: (value, index) async {
                setState(() {
                  highpriortyTasks[index!].isDone = value ?? false;
                });
                final allDate = PreferencesManager().getString("tasks");
                if (allDate != null) {
                  List<TaskModel> allDataList = (jsonDecode(allDate) as List)
                      .map((element) => TaskModel.fromJSON(element))
                      .toList();
                  final newIndex = allDataList.indexWhere(
                    (e) => e.id == highpriortyTasks[index!].id,
                  );
                  allDataList[newIndex] = highpriortyTasks[index!];
                  await PreferencesManager().setString(
                    "tasks",
                    jsonEncode(allDataList.map((e) => e.toJeson()).toList()),
                  );
                  _loadTask();
                }
              },
              onDelet: (int? id) {
                _deletTask(id);
              },  onEdit: () {
              _loadTask();
            },
            ),
          ],
        ),
      ),
    );
  }
}
