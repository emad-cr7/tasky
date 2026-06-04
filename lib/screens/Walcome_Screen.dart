import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/servies/preferences_manager.dart';
import '../core/widgets/custom_svg_picture.dart';
import '../core/widgets/custom_text_from_feild.dart';
import 'main_screen.dart';

class WalcomeScreen extends StatelessWidget {
  WalcomeScreen({super.key});

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
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomSvgPicture.withColor(path: "assets/images/Vector.svg",),
                        SizedBox(width: 16),
                        Text(
                          "Tasky",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 118),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome To Tasky ",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        SizedBox(width: 8),
                        CustomSvgPicture.withColor(path: "assets/images/waving_hand.svg",),

                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Your productivity journey starts here.",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 24),
                    SvgPicture.asset(
                      "assets/images/pana.svg",
                      width: 215,
                      height: 200,
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextFromFeild(
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
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(fixedSize: Size(340, 40)),
                      onPressed: () async {
                        if (_key.currentState?.validate() ?? false) {
                          await PreferencesManager().setString(
                            'username',
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
            ),
          ),
        ),
      ),
    );
  }
}
