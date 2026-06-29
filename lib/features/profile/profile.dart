import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/features/profile/profile_controller.dart';
import '../../core/theme/theme_controller.dart';
import 'components/dark_mode_component.dart';
import 'components/log_out_component.dart';
import 'components/user_details_component.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileController()..init(),
      child: Consumer<ProfileController>(
        builder: (BuildContext context, ProfileController controller, Widget? child) {
          return controller.isLoading
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding:  EdgeInsets.all(AppSizes.w16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "My Profile",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        SizedBox(height: AppSizes.h16),
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
                                    radius:60,
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
                                      width:AppSizes.w34 ,
                                      height:AppSizes.h34 ,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          AppSizes.r100,
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
                              SizedBox(height: AppSizes.h8),
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
                              SizedBox(height: AppSizes.ph24),
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
                            SizedBox(height: AppSizes.h16),
                            UserDetailsComponent(controller: controller,),
                            SizedBox(height: AppSizes.h8),
                            DarkModeComponent(),
                            SizedBox(height: AppSizes.h8),
                            LogOutComponent(),
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

