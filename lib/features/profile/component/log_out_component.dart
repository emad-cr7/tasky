import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../tasks/cotrollers/tasks_controller.dart';

class LogOutComponent extends StatelessWidget {
  const LogOutComponent({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
