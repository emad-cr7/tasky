import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/modles/taskmodel.dart';

import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';

class HomeController with ChangeNotifier {
  String? username;
  String? userImage;
  bool isLoading = true;

  init() {
    loadUserData();
  }

  void loadUserData() async {
    username = PreferencesManager().getString(StorageKey.username);
    userImage = PreferencesManager().getString(StorageKey.userImage);
    notifyListeners();
  }
}
