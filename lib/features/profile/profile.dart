import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/servies/preferences_manager.dart';
import 'package:tasky/main.dart';
import 'package:tasky/features/profile/user_detalis.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../welcome/Welcome_Screen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? username;
  String? motivation;
  String? userImage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      username = PreferencesManager().getString("username");
      motivation = PreferencesManager().getString("motivation");
      userImage = PreferencesManager().getString("user_image");
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Profile",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundImage: userImage == null
                                  ? AssetImage("assets/images/cr.jpg")
                                  : FileImage(File(userImage!)),
                              radius: 60,
                              backgroundColor: Colors.transparent,
                            ),
                            GestureDetector(
                              onTap: () async {
                                showImageSourcDialog(context, (XFile file) {
                                  _saveImage(file);
                                  setState(() {
                                    userImage = file.path;
                                  });
                                });
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: ThemeController.isDark()
                                      ? null
                                      : Border.all(color: Color(0xffD1DAD6)),

                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primaryContainer,
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Text(
                              "$username",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        Text(
                          motivation ?? "One task at a time. One step closer.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Info",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      SizedBox(height: 19),
                      Row(
                        children: [
                          SizedBox(width: 2),
                          Expanded(
                            child: ListTile(
                              title: Text("User Details"),
                              contentPadding: EdgeInsets.zero,
                              leading: CustomSvgPicture(
                                path: "assets/images/profile_Icon.svg",
                              ),
                              trailing: CustomSvgPicture(
                                path: "assets/images/back_Icon.svg",
                              ),
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return UserDetalis(
                                        user: '$username',
                                        motivation:
                                            "One task at a time. One step closer.",
                                      );
                                    },
                                  ),
                                );

                                if (result == true) {
                                  _loadData();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(thickness: 1),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Dark Mode"),
                              leading: CustomSvgPicture(
                                path: "assets/images/dark.svg",
                              ),

                              trailing: ValueListenableBuilder(
                                valueListenable: ThemeController.themNotifier,
                                builder:
                                    (
                                      BuildContext context,
                                      value,
                                      Widget? child,
                                    ) {
                                      return Switch(
                                        value: value == ThemeMode.dark,
                                        onChanged: (value) {
                                          ThemeController.toggleThem();
                                        },
                                      );
                                    },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Divider(thickness: 1),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "Log Out",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                              leading: SvgPicture.asset(
                                "assets/images/logout_Icon.svg",
                                colorFilter: ColorFilter.mode(
                                  Colors.red,
                                  BlendMode.srcIn,
                                ),
                              ),

                              trailing: SvgPicture.asset(
                                "assets/images/back_Icon.svg",
                                colorFilter: ColorFilter.mode(
                                  Colors.red,
                                  BlendMode.srcIn,
                                ),
                              ),
                              onTap: () async {
                                _showAlertDialog(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    await PreferencesManager().setString("user_image", newFile.path);
  }
}

void showImageSourcDialog(
    BuildContext context, Function(XFile) selectedFile) {
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
}
void _showAlertDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Log out"),
        content: Text(
          "Are you sure Log out of your account",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),

          TextButton(
            onPressed: () {
              PreferencesManager().remove("username");
              PreferencesManager().remove("motivation");
              PreferencesManager().remove("tasks");
              PreferencesManager().remove("user_image");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return WelcomeScreen();
                  },
                ),
                    (Route<dynamic> route) => false,
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Log out"),

          ),
        ],
      );
    },
  );
}
