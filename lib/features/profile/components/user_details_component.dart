import 'package:flutter/material.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import '../../../core/widgets/custom_svg_picture.dart';
import '../user_detalis.dart';
class UserDetailsComponent extends StatelessWidget {
   UserDetailsComponent({super.key , required this.controller});

  var controller ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: AppSizes.w2),
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
                            user: '${controller.username}',
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
        Divider(thickness: 1),

      ],
    );
  }
}
