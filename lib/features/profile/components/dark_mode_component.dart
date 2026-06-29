import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/custom_svg_picture.dart';

class DarkModeComponent extends StatelessWidget {
  const DarkModeComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Dark Mode"),
                  leading: CustomSvgPicture(path: "assets/images/dark.svg"),

                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themNotifier,
                    builder: (BuildContext context, value, Widget? child) {
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
        Divider(thickness: 1),
      ],
    );
  }
}
