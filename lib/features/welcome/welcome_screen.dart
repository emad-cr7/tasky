import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';
import '../../core/widgets/custom_svg_picture.dart';
import '../../core/widgets/custom_text_from_feild.dart';
import '../navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                    children: [
                      SizedBox(height: AppSizes.h16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSvgPicture.withColor(
                            path: "assets/images/Vector.svg",
                          ),
                          SizedBox(width: AppSizes.w16),
                          Text(
                            "Tasky",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.ph100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Welcome To Tasky ",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(width: AppSizes.w8),
                          CustomSvgPicture.withColor(
                            path: "assets/images/waving_hand.svg",
                            height: AppSizes.h42,
                            width: AppSizes.w42,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSizes.h8),
                      Text(
                        "Your productivity journey starts here.",
                        style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: AppSizes.sp16,
                        ),
                      ),
                      SizedBox(height: AppSizes.ph24),
                      Skeleton.shade(
                        child: SvgPicture.asset(
                          "assets/images/pana.svg",
                          width: AppSizes.h200,
                          height: AppSizes.w200,
                        ),
                      ),
                      SizedBox(height: AppSizes.h24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
                  
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFromField(
                              title: "Full Name",
                              controller: controller,
                              hint: "Enter Full Name",
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please Enter Your Full Name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: AppSizes.h24),
                            ElevatedButton(
                              onPressed: () async {
                                if (_key.currentState?.validate() ?? false) {
                                  await PreferencesManager().setString(
                                    StorageKey.username,
                                    controller.text,
                                  );
                  
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return MainScreen();
                                      },
                                    ),
                                  );
                                } else {}
                              },
                              child: Text("Let’s Get Started"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  }
}
