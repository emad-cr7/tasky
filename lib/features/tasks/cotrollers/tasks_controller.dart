import 'package:flutter/material.dart';
import '../../../core/constants/storage_key.dart';
import '../../../core/servies/file_storage_manager.dart';
import '../../../core/servies/preferences_manager.dart';
import '../../../models/task_model.dart';

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

  void loadTask() async {
    tasks = HiveStorageManager().loadTask();
    loadData();
    _calculatePecent();

    isLoading = false;
    notifyListeners();
  }

  loadData() {
    todoTasks = tasks.where((e) => !e.isDone).toList();
    completed = tasks.where((e) => e.isDone).toList();
    highPriorityTasks = tasks
        .where((element) => element.isHighPriority == true)
        .toList()
        .reversed
        .toList();
  }

  void doneTasks(bool? value, int id) async {
    final index = tasks.indexWhere((e) => e.id == id);

    tasks[index].isDone = value ?? false;

    loadData();
    _calculatePecent();
    HiveStorageManager().saveTasks(tasks);
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

    HiveStorageManager().saveTasks(tasks);

    notifyListeners();
  }

  clearTasks() {
    PreferencesManager().remove(StorageKey.userImage);
    loadTask();
  }
}
