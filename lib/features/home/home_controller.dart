import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/modles/taskmodel.dart';

import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';

class HomeController with ChangeNotifier {
  String? username;
  String? userImage;
  List<TaskModel> tasks = [];
  bool isLoading = true;
  int totalTask = 0;
  int doneTask = 0;
  double percent = 0;

  init() {
    loadUserData();
    loadTask();
  }

  void loadUserData() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImage = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }

  void loadTask() async {
    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskDecode.map((element) => TaskModel.fromJSON(element)).toList();
      calculatePecent();
    }
    isLoading = false;
    notifyListeners();
  }

  calculatePecent() {
    totalTask = tasks.length;
    doneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : doneTask / totalTask;
    notifyListeners();
  }

  donTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePecent();
    final UpdatedTask = tasks.map((element) => element.toJeson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(UpdatedTask));
    notifyListeners();
  }

  deletTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((task) => task.id == id);
    calculatePecent();
    final UpdatedTask = tasks.map((element) => element.toJeson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(UpdatedTask));
    notifyListeners();
  }
}