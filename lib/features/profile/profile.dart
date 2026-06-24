import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/profile/profile_controller.dart';
import 'package:tasky/features/profile/user_detalis.dart';
import 'package:tasky/features/tasks/cotrollers/tasks_controller.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/widgets/custom_svg_picture.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileController()..init(),
      child: Consumer<ProfileController>(
        builder:
            (
              BuildContext context,
              ProfileController controller,
              Widget? child,
            ) {
              return controller.isLoading
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
                                        backgroundImage:
                                            controller.userImage == null
                                            ? AssetImage(
                                                "assets/images/profile.png",
                                              )
                                            : FileImage(
                                                File(controller.userImage!),
                                              ),
                                        radius: 60,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          controller.showImageSourcDialog(
                                            context,
                                            (XFile file) {
                                              controller.saveImage(file);
                                              controller.userImage = file.path;
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 45,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                            border: ThemeController.isDark()
                                                ? null
                                                : Border.all(
                                                    color: Color(0xffD1DAD6),
                                                  ),

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
                                        "${controller.username}",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    controller.motivation ??
                                        "One task at a time. One step closer.",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
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
                                                  user:
                                                      '${controller.username}',
                                                  motivation:
                                                      "One task at a time. One step closer.",
                                                );
                                              },
                                            ),
                                          );

                                          if (result == true) {
                                            controller.init();
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text("Dark Mode"),
                                        leading: CustomSvgPicture(
                                          path: "assets/images/dark.svg",
                                        ),

                                        trailing: ValueListenableBuilder(
                                          valueListenable:
                                              ThemeController.themNotifier,
                                          builder:
                                              (
                                                BuildContext context,
                                                value,
                                                Widget? child,
                                              ) {
                                                return Switch(
                                                  value:
                                                      value == ThemeMode.dark,
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
            },
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChangeNotifierProvider<TasksController>(
        create: (BuildContext context) => TasksController()..init(),
        child: AlertDialog(
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
              onPressed: () async {
                context.read<TasksController>().clearTasks(context);
              },

              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text("Log out"),
            ),
          ],
        ),
      );
    },
  );
}
