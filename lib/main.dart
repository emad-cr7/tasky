import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/servies/file_storage_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/features/tasks/cotrollers/tasks_controller.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';
import 'package:tasky/features/navigation/main_screen.dart';
import 'core/constants/storage_key.dart';
import 'core/servies/preferences_manager.dart';
import 'core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  await PreferencesManager().init();
  await HiveStorageManager().init();

  ThemeController().init();
  String? username = PreferencesManager().getString(StorageKey.username);

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
        return ChangeNotifierProvider<TasksController>(
          create: (_) => TasksController()..init(),
          child: ScreenUtilInit(
            designSize:Size(375, 809) ,
            minTextAdapt: true,
            builder: (context , _){
              return MaterialApp(
                title: 'Tasky APP',
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: themeMode,
                home: username == null ? WelcomeScreen() : MainScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
