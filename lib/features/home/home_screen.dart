import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/animation/custom_animation4.dart';
import 'package:tasky/features/tasks/cotrollers/tasks_controller.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/widgets/custom_svg_picture.dart';
import 'components/achieved_tasks.dart';
import 'components/high_priority_tasks.dart';
import '../add_task/add_task.dart';
import 'components/sillver_task_list.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.all(AppSizes.pw16),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: AppSizes.w8),

                          child: Selector<HomeController, String?>(
                            selector: (context, controller) =>
                                controller.userImage,
                            builder:
                                (
                                  BuildContext context,
                                  String? userImage,
                                  Widget? child,
                                ) {
                                  return CircleAvatar(
                                    backgroundImage: userImage == null
                                        ? AssetImage(
                                            "assets/images/profile.png",
                                          )
                                        : FileImage(File(userImage!)),
                                    backgroundColor: Colors.transparent,
                                  );
                                },
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              selector: (context, controller) =>
                                  controller.username,
                              builder:
                                  (
                                    BuildContext context,
                                    String? username,
                                    Widget? child,
                                  ) {
                                    return Text(
                                      "Good Evening ,$username ",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    );
                                  },
                            ),
                            Text(
                              "One task at a time.One step\ncloser.",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h16),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.start,
                          "Yuhuu ,Your work Is",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Row(
                          children: [
                            Text(
                              textAlign: TextAlign.start,
                              "almost done !  ",
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            CustomSvgPicture.withColor(
                              path: "assets/images/waving_hand.svg",
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.h16),
                    AchievedTasks(),
                    SizedBox(height: AppSizes.h8),
                    HighPriorityTasks(),
                    Padding(
                      padding:  EdgeInsets.only(top: AppSizes.ph24, bottom: AppSizes.ph16),
                      child: Text(
                        'My Tasks',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Silver_task_list(emptyTask: "No Tasks"),
            ],
          ),
        ),

        floatingActionButton: SizedBox(
          height: AppSizes.h44,
          child: Builder(
            builder: (BuildContext context) {
              return CustomAnimation4(
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    final bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Add_task();
                        },
                      ),
                    );
                    if (result != null && result) {
                      context.read<TasksController>().init();
                    }
                  },
                  label: Text("Add New Task"),
                  icon: Icon(Icons.add),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
