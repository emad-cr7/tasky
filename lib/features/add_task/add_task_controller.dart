import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/constants/storage_key.dart';
import '../../core/servies/file_storage_manager.dart';
import '../../core/servies/preferences_manager.dart';
import '../../models/task_model.dart';

class AddTaskController with ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final taskJson =  PreferencesManager().getString(StorageKey.tasks);

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

      listTasks.add(model.toJson());


      FileStorageManager().saveTasks(listTasks);



      final taskEncode = jsonEncode(listTasks);
      await PreferencesManager().setString(StorageKey.tasks, taskEncode);

      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value ;

    notifyListeners();
  }


}