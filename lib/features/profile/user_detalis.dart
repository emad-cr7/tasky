import 'package:flutter/material.dart';
import '../../core/constants/storage_key.dart';
import '../../core/servies/preferences_manager.dart';
import '../../core/widgets/custom_text_from_feild.dart';

class UserDetalis extends StatefulWidget {
  UserDetalis({super.key, required this.user, required this.motivation});

  String user;

  String motivation;

  @override
  State<UserDetalis> createState() => _UserDetalisState();
}

class _UserDetalisState extends State<UserDetalis> {
  final TextEditingController userController = TextEditingController();

  final TextEditingController motivationController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    userController.text = widget.user;
    motivationController.text = widget.motivation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Detalis")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFromField(
                        title: "User Name",
                        controller: userController,
                        hint: "User Name New",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter User Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomTextFromField(
                        title: "Motivation Quote",
                        controller: motivationController,
                        maxLines: 5,
                        hint: "One task at a time. One step closer.",
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter User Name";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    PreferencesManager().setString(StorageKey.username, userController.text,);
                    PreferencesManager().setString(StorageKey.motivation,
                      motivationController.text,
                    );

                    Navigator.of(context).pop(true);
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.maxFinite, 40),
                ),
                child: Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
