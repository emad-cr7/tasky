import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/animation/custom_animation.dart';
import '../../../core/widgets/animation/custom_animation2.dart';
import '../../../core/widgets/custom_check_box.dart';
import '../../tasks/cotrollers/tasks_controller.dart';
import '../../tasks/high_priorty_screen.dart';

class HighPriorityTasks extends StatelessWidget {
  const HighPriorityTasks({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        final tasksList = controller.tasks ;
        return CustomAnimation2(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ThemeController.isDark()
                    ? Colors.transparent
                    : Color(0xffD1DAD6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "High Priority Tasks",
                          style: TextStyle(
                            color: Color(0XFF15B86C),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        ...tasksList.reversed.where((t) => t.isHighPriority).take(4).map((task) {
                          return Row(
                            children: [
                              CustomCheckBox(
                                value: task.isDone,
                                onChanged: (bool? value) {
          
                                  controller.doneTasks(value, task.id);
                                },
                              ),
          
                              Expanded(
                                child: Text(
                                  maxLines: 1,
                                  task.taskName,
                                  style: task.isDone
                                      ? Theme.of(context).textTheme.titleLarge
                                      : Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return HighPriortyScreen();
                              },
                            ),
                          );
                          controller.loadTask();
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 56,
                              width: 48,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                shape: BoxShape.circle,
                                border: Border.all(color: ThemeController.isDark()
                                    ?Color(0xff6E6E6E)
                                    :Color(0xffD1DAD6)
                                ),
                              ),
                            ),
                            SvgPicture.asset(
                              "assets/images/back2.svg",
                              height: 15,
                              width: 15,
                              colorFilter: ColorFilter.mode(
                                  ThemeController.isDark()
                                      ?Color(0xffC6C6C6)
                                      :Color(0XFF3A4640),
                                  BlendMode.srcIn
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}