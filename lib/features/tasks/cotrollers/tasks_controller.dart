import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/modles/taskmodel.dart';

import '../../../core/constants/storage_key.dart';
import '../../../core/servies/preferences_manager.dart';

class TasksController with ChangeNotifier {
  bool isLoading = true;

  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completed = [];
  List<TaskModel> highPriorityTasks = [];

  init() {
    loadTask();
  }

  void loadTask() async {
    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskDecode.map((element) => TaskModel.fromJSON(element)).toList();
      todoTasks = tasks.where((e) => !e.isDone).toList();
      completed = tasks.where((e) => e.isDone).toList();
      highPriorityTasks = tasks
          .where((element) => element.isHighPriority == true)
          .toList()
          .reversed
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }

  void donnTask(bool? value, int? index) async {
    if (index == null) return;
    todoTasks[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere((e) => e.id == todoTasks[index].id);
    tasks[newIndex] = todoTasks[index];
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toJeson()).toList()),
    );
    loadTask();

    notifyListeners();
  }

  void doneCompletedTask(bool? value, int? index) async {
    if (index == null) return;
    completed[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere((e) => e.id == completed[index].id);
    tasks[newIndex] = completed[index];
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toJeson()).toList()),
    );
    loadTask();

    notifyListeners();
  }

  void doneHighPriorityTasksTask(bool? value, int? index) async {
    if (index == null) return;
    highPriorityTasks[index].isDone = value ?? false;

    final newIndex = tasks.indexWhere(
          (e) => e.id == highPriorityTasks[index].id,
    );
    tasks[newIndex] = highPriorityTasks[index];
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(tasks.map((e) => e.toJeson()).toList()),
    );
    loadTask();

    notifyListeners();
  }

  deletTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((e) => e.id == id);
    todoTasks.removeWhere((task) => task.id == id);
    completed.removeWhere((task) => task.id == id);
    highPriorityTasks.removeWhere((task) => task.id == id);

    final updatedTask = tasks.map((element) => element.toJeson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }
}