import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tasky/modles/taskmodel.dart';
import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';
import '../../core/widgets/custom_svg_picture.dart';
import 'components/achieved_tasks.dart';
import 'components/high_priority_tasks.dart';
import '../../core/components/sillver_task_list.dart';
import '../../core/components/task_list.dart';
import '../add_task/add_task.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? userImage;
  List<TaskModel> tasks = [];
  bool isLoading = true;
  int totalTask = 0;
  int doneTask = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadTask();
  }

  void _loadUserName() async {
    setState(() {
      username = PreferencesManager().getString(StorageKey.username);
      userImage = PreferencesManager().getString("user_image");
    });
  }

  void _loadTask() async {
    final finalTask = PreferencesManager().getString("tasks");
    if (finalTask != null) {
      final taskDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskDecode.map((element) => TaskModel.fromJSON(element)).toList();
      _calculatePecent();
    }
    setState(() {
      isLoading = false;
    });
  }

  _donTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePecent();
    });
    final UpdatedTask = tasks.map((element) => element.toJeson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(UpdatedTask));
  }

  _calculatePecent() {
    totalTask = tasks.length;
    doneTask = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : doneTask / totalTask;
  }

  _deletTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((task) => task.id == id);

      _calculatePecent();
    });
    final UpdatedTask = tasks.map((element) => element.toJeson()).toList();
    PreferencesManager().setString("tasks", jsonEncode(UpdatedTask));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : CustomScrollView(
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
                                backgroundImage: userImage == null
                                    ? AssetImage("assets/images/cr.jpg")
                                    : FileImage(File(userImage!)),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Evening ,$username ",
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
                          totalTask: totalTask,
                          doneTask: doneTask,
                          percent: percent,
                        ),
                        SizedBox(height: 8),
                        HighPriorityTasks(
                          tasks: tasks,
                          onTap: (bool? value, int? index) {
                            _donTask(value, index);
                          },
                          refresh: () {
                            _loadTask();
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
                    tasks: tasks,
                    onTap: (bool? value, int? index) {
                      _donTask(value, index);
                    },
                    onDelet: (int? id) {
                      _deletTask(id);
                    },
                    onEdit: () {
                      _loadTask();
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
              _loadTask();
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
  }
}
