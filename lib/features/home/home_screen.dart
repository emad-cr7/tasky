import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/modles/taskmodel.dart';
import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';
import '../../core/widgets/custom_svg_picture.dart';
import 'components/achieved_tasks.dart';
import 'components/high_priority_tasks.dart';
import '../../core/components/sillver_task_list.dart';
import '../../core/components/task_list.dart';
import '../add_task/add_task.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, HomeController value, Widget? child) {
          final controller = context.read<HomeController>();
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
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
                              padding: EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                backgroundImage: value.userImage == null
                                    ? AssetImage("assets/images/cr.jpg")
                                    : FileImage(File(value.userImage!)),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Evening ,${value.username} ",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  "One task at a time.One step\ncloser.",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
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
                        SizedBox(height: 16),
                        AchievedTasks(
                          totalTask: value.totalTask,
                          doneTask: value.doneTask,
                          percent: value.percent,
                        ),
                        SizedBox(height: 8),
                        HighPriorityTasks(
                          tasks: value.tasks,
                          onTap: (bool? value, int? index) {
                            controller.donTask(value, index);
                          },
                          refresh: () {
                            controller.loadTask();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 16),
                          child: Text(
                            'My Tasks',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Silver_task_list(
                    emptyTask: "No Tasks",
                    tasks: value.tasks,
                    onTap: (bool? value, int? index) {
                      controller.donTask(value, index);
                    },
                    onDelet: (int? id) {
                      controller.deletTask(id);
                    },
                    onEdit: () {
                      controller.loadTask();
                    },
                  ),
                ],
              ),
            ),

            floatingActionButton: SizedBox(
              height: 44,
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
                    controller.loadTask();
                  }
                },
                label: Text("Add New Task"),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
