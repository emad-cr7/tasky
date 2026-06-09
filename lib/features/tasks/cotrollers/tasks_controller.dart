import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/modles/taskmodel.dart';

import '../../../core/constants/storage_key.dart';
import '../../../core/servies/preferences_manager.dart';

class TasksController with ChangeNotifier {
  bool isLoading = true;
  int totalTask = 0;
  int doneTask = 0;
  double percent = 0;
  List<TaskModel> tasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> completed = [];
  List<TaskModel> highPriorityTasks = [];

  init() {
    loadTask();
  }

  Future<void> loadTask() async {
    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskDecode.map((element) => TaskModel.fromJSON(element)).toList();

      loadData();

      _calculatePecent();
    }
    isLoading = false;
    notifyListeners();
  }

  loadData() {
    todoTasks = tasks.where((e) => !e.isDone).toList();
    completed = tasks.where((e) => e.isDone).toList();
    highPriorityTasks = tasks.where((element) => element.isHighPriority == true).toList()
        .reversed
        .toList();
  }

  void doneTasks(bool? value, int id) async {
    final index = tasks.indexWhere((e) => e.id == id);

    tasks[index].isDone = value ?? false;

    loadData();
    _calculatePecent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();

    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }

  _calculatePecent() {
    totalTask = tasks.length;
    doneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : doneTask / totalTask;
    notifyListeners();
  }

  deletTask(int? id) async {

    if (id == null) return;
    tasks.removeWhere((e) => e.id == id);
    loadData();
    _calculatePecent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }
}
