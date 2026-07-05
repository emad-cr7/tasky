import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';

class ProfileController with ChangeNotifier {
  String? username;
  String? motivation;
  String? userImage;
  bool isLoading = true;

  @override
  void init() {
    _loadData();
  }

  void _loadData() async {
    username = PreferencesManager().getString(StorageKey.username);
    motivation = PreferencesManager().getString(StorageKey.motivation);
    userImage = PreferencesManager().getString(StorageKey.userImage);
    isLoading = false;
    notifyListeners();
  }
  void saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    await PreferencesManager().setString(StorageKey.userImage, newFile.path);
    notifyListeners();

  }



  void showImageSourcDialog(BuildContext context, Function(XFile) selectedFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            "Choose Image Source",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 8),
                  Text("Camara"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text("Gallery"),
                ],
              ),
            ),
          ],
        );
      },
    );
    notifyListeners();

  }
}
