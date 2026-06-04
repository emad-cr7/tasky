import 'package:flutter/material.dart';

import '../servies/preferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themNotifier = ValueNotifier(ThemeMode.dark,);

  init() {
    bool? result = PreferencesManager().getBool("theme") ?? true;

    themNotifier.value = result == true ? ThemeMode.dark : ThemeMode.light;
  }
 static toggleThem()async{

    if(themNotifier.value == ThemeMode.dark){

      themNotifier.value =ThemeMode.light;
      await  PreferencesManager().setBool("theme", false);

    }else{
      themNotifier.value =ThemeMode.dark;
      await PreferencesManager().setBool("theme", true);

    }
  }
  static bool isDark() => themNotifier.value == ThemeMode.dark ;

}
