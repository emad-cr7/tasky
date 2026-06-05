import 'package:flutter/material.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/features/welcome/Welcome_Screen.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'core/servies/preferences_manager.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();

  ThemeController().init();
  String? username = PreferencesManager().getString('username');

  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  final String? username;

  const MyApp({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themNotifier,
      builder: (context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky APP',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: username == null ? WelcomeScreen() : MainScreen(),
        );
      },
    );
  }
}
